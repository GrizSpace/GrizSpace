namespace :db do
  SQLITE = ENV['SQLITE'] || 'sqlite3'
  DB     = ENV['DB'] || 'GrizSpace/GrizSpaceDB.sqlite'
  SEED   = 'data/seed.sql'
  SCHEMA = 'data/schema.sql'

  desc "dump the SQLite schema to #{SCHEMA}"
  task :schema do
    sh "#{SQLITE} #{DB} .sch > #{SCHEMA}"
  end

  desc "dump SQLite data to #{SEED}"
  task :data do
    grep = 'egrep "^(PRAGMA|BEGIN|COMMIT|INSERT)"'
    sh "#{SQLITE} #{DB} .dump | #{grep} > #{SEED}"
  end

  desc "dump the schema and data"
  task :dump => [:schema, :data]

  desc 'reset the database'
  task :clear do
    rm_rf DB
    sh "touch #{DB}"
  end

  desc 'delete and reload the database'
  task :setup => :clear do
    [SCHEMA, SEED].each { |f| sh "#{SQLITE} #{DB} < #{f}" }
  end
end

def get_building_id(dbh, row)
  abbr = row['BLDG']
  bldg = dbh[:Building].filter(:abbr => abbr).first

  return bldg[:id] if bldg

  STDERR.puts "WARNING: Building #{abbr} does not exist"
end

def fetch_id(dbh, table, params)
  rs = dbh[table].filter(params).first

  rs ? rs[:id] : dbh[table].insert(params)
end

def get_subject_id(dbh, row)
  fetch_id(dbh, :Subject, :abbr => row['SUBJ'])
end

def get_course_id(dbh, row, subj_id)
  fetch_id(dbh, :Course, :number => row['CRSE #'], :subject_id => subj_id)
end

def get_room_id(dbh, row, bldg_id)
  fetch_id(dbh, :Classroom, :room => row['ROOM'], :building_id => bldg_id)
end

def daymask(str)
  return 0 if str.to_s.empty?
  table = Hash.new(0).tap do |hsh|
    %w(M T W R F S U).map.with_index { |d, i| hsh[d] = 2**i }
  end
  str.split(//).map { |char| table[char] }.reduce(:+)
end

def parse_time(str)
  str ? row['TIME'].split('-') : ['', '']
end

desc 'import course list'
task :import => 'db:setup' do
  abort "ERROR: Ruby 1.9+ is required" if RUBY_VERSION < "1.9"
  csv = ENV['CSV'] || 'data/courses.csv'
  abort '#{csv} does not exist' unless File.exists?(csv)

  require 'csv'
  require 'sequel'

  dbh = Sequel.connect(:adapter => 'sqlite', :database => DB)
  dbh.foreign_keys()

  # section counter
  seen_courses = Hash.new(0)

  semester = fetch_id(dbh, :Semester, :year => 2012, :season => 'SP')
  CSV.foreach(csv, :headers => true) do |row|
    building = get_building_id(dbh, row)
    next unless building
    subject  = get_subject_id(dbh, row)
    course   = get_course_id(dbh, row, subject)
    room     = get_room_id(dbh, row, building)
    days     = daymask(row['DAYS'])
    s_num    = (seen_courses[row['CRSE #']] += 1)
    start_t, end_t = parse_time(row['TIMES'])

    params = {
      :crn          => row['CRN'],
      :number       => s_num,
      :start_time   => start_t,
      :end_time     => end_t,
      :days         => days,
      :course_id    => course,
      :classroom_id => room,
      :semester_id  => semester
    }

    section = fetch_id(dbh, :CourseSection, params)
  end
end
