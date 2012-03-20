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

desc 'import course list'
task :import do
  abort "ERROR: Ruby 1.9+ is required" if RUBY_VERSION < "1.9"
  csv = ENV['CSV'] || 'data/courses.csv'
  abort '#{csv} does not exist' unless File.exists?(csv)

  require 'csv'
  require 'sequel'

  unk = Hash.new(0)
  dbh = Sequel.connect(:adapter => 'sqlite', :database => DB)
  dbh.foreign_keys()

  CSV.foreach(csv, :headers => true) do |row|
    bldg = row['BLDG']
    rs   = dbh[:Building].filter(:idBuilding => bldg).first
    if !rs
      unk[bldg] += 1
      next
    end

    subjstr = row['SUBJ']
    subj_id = dbh[:Subject].filter(:idSubject => subjstr).first
    if !subj_id
      dbh[:Subject].insert(:idSubject => subjstr)
      subj_id = dbh[:Subject].filter(:idSubject => subjstr).first
    end
    subj_id = subj_id[:idSubject]

    course = dbh[:Course].filter(:CourseNumber => row['CRSE #'])
    unless course
      dbh[:Course].insert(:CourseNumber => row['CRSE #'], :fk_idSubject => subj_id)
    end
  end

  STDERR.puts "The following buildings must be imported:\nBLDG\t# Classes"
  STDERR.puts "-" * 20
  unk.sort { |a, b| b[1] <=> a[1] }.each do |name, num|
    STDERR.puts "#{name}\t#{num}"
  end
end
