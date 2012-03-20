namespace :db do
  SQLITE = ENV['SQLITE'] || 'sqlite3'
  DB     = ENV['DB'] || 'GrizSpace/GrizSpaceDB.sqlite'
  SCHEMA = 'data/schema.sql'

  desc 'dump SQLite schema to data/schema.sql'
  task :dump do
    sh "%s %s .dump > %s" % [SQLITE, DB, SCHEMA]
    STDERR.puts "Dumped to #{SCHEMA}"
  end
end
