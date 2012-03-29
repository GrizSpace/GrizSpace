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

def get_subject_id(dbh, row)
  params = {:abbr => row['SUBJ']}
  subj = dbh[:Subject].filter(params).first

  subj ? subj[:id] : dbh[:Subject].insert(params)
end

def get_course_id(dbh, row, subj_id)
  params = {:number => row['CRSE #'], :subject_id => subj_id}
  course = dbh[:Course].filter(params).first

  course ? course[:id] : dbh[:Course].insert(params)
end

def get_room_id(dbh, row, bldg_id)
  params = {:room => row['ROOM'], :building_id => bldg_id}
  room = dbh[:Classroom].filter(params).first

  room ? room[:id] : dbh[:Classroom].insert(params)
end

desc 'import course list'
task :import do
  abort "ERROR: Ruby 1.9+ is required" if RUBY_VERSION < "1.9"
  csv = ENV['CSV'] || 'data/courses.csv'
  abort '#{csv} does not exist' unless File.exists?(csv)

  require 'csv'
  require 'sequel'

  dbh = Sequel.connect(:adapter => 'sqlite', :database => DB)
  dbh.foreign_keys()

  CSV.foreach(csv, :headers => true) do |row|
    building = get_building_id(dbh, row)
    subject  = get_subject_id(dbh, row)
    course   = get_course_id(dbh, row, subject)
    room     = get_room_id(dbh, row, building)
  end
end
