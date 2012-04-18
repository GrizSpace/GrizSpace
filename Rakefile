SQLITE = ENV['SQLITE'] || 'sqlite3'
DB     = ENV['DB'] || 'GrizSpace/GrizSpaceDB.sqlite'

def get_dbh
  require 'sequel'
  dbh = Sequel.connect(:adapter => 'sqlite', :database => DB)
  dbh.foreign_keys()
  dbh
end

namespace :db do
  SEED   = 'data/seed.sql'
  SCHEMA = 'data/schema.sql'

  desc "open #{DB}"
  task :open do
    sh "#{SQLITE} #{DB}"
  end

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

def get_building_and_room_ids(dbh, str)
  abbr, num = str.split(/ /)
  bldg = get_building_id(dbh, abbr)

  return nil unless bldg

  room = get_room_id(dbh, bldg, room)

  [bldg, room]
end

def get_building_id(dbh, abbr)
  bldg = dbh[:Building].filter(:abbr => abbr).first
  return bldg[:id] if bldg
  STDERR.puts "WARNING: Building #{abbr} does not exist"
end

def fetch_id(dbh, table, params)
  rs = dbh[table].filter(params).first

  rs ? rs[:id] : dbh[table].insert(params)
end

def get_subject_id(dbh, abbr)
  fetch_id(dbh, :Subject, :abbr => abbr)
end

def get_course_id(dbh, params)
  fetch_id(dbh, :Course, params)
end

def get_room_id(dbh, bldg_id, room)
  fetch_id(dbh, :Classroom, :room => room, :building_id => bldg_id)
end

def daymask(str)
  return 0 if str.to_s.empty?
  table = Hash.new(0).tap do |hsh|
    %w(M T W R F S U).map.with_index { |d, i| hsh[d] = 2**i }
  end
  str.split(//).map { |char| table[char] }.reduce(:+)
end

def parse_time(str)
  key = :time
  matches = str.match /Time:(?<start>\d+:\d+(AM|PM))-(?<end>\d+:\d+(AM|PM))/
  matches ? [matches[:start], matches[:end]] : [nil, nil]
end

# The course line includes escaped newlines and tabs, but we can use split on
# them for each field.
def course_line_to_fields(line)
  line.split(/\\n/).map { |x| x.split(/\\t/) }.flatten.map { |x| x.strip }
end

def parse_abbr_num_sect(str)
  a, n, s = str.strip.gsub('-', '').split(/ /).delete_if { |x| x.empty? }
  s ||= 1
  [a, n, s]
end

desc 'Import courses from the Academic Planner'
task :import_courses => 'db:setup' do
  dbh      = get_dbh()
  fn       = 'data/course-import.txt'
  semester = fetch_id(dbh, :Semester, :year => 2012, :season => 'SP')

  File.readlines(fn).each do |line|
    h = {}
    course_line_to_fields(line).each do |field|
      if field =~ /Time/
        h[:time] = parse_time(field)
      else
        key, value = field.split(/:/).map { |x| x.gsub(/[",']/, '') }
        h[key] = value
      end
    end

    abbr, num, sect = parse_abbr_num_sect(h['Course Number'])
    subj   = get_subject_id(dbh, abbr)
    days   = daymask(h['Days'].gsub('-', ''))
    course = get_course_id(dbh, :title => h['Title'], :number => num, :subject_id => subj)

    bldg, room = get_building_and_room_ids(dbh, h['Building and Room'].to_s)
    next unless bldg

    params = {
      :crn          => h['CRN'],
      :number       => sect,
      :start_time   => h[:time][0],
      :end_time     => h[:time][1],
      :days         => days,
      :course_id    => course,
      :classroom_id => room,
      :semester_id  => semester,
    }

    fetch_id(dbh, :CourseSection, params)
  end
end

desc 'Imports the list of subjects from the Academic Planner'
task :import_subjects do
  # Go to <http://www.umt.edu/academicplanner/coursesearch/search.html> in
  # Chrome every semester, right-click the subject dropdown to select "Inspect
  # Element". Then right-click the <select class....> HTML and select "Copy as
  # HTML". In Terminal, do pbpaste > subjects.html.
  dbh = get_dbh()
  fn  = 'data/subjects.html'

  opts = File.read(fn).gsub('&amp;', '&').split('</option>')
  opts.shift # remove <select...>
  opts.pop   # remove </select>

  opts.each do |o|
    matches = o.match /\>(?<title>.+)\((?<abbr>.+)\)$/
    s = {:abbr => matches[:abbr].strip, :title => matches[:title].strip}
    fetch_id(dbh, :Subject, s)
  end
end
