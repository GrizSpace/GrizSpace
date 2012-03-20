desc 'dump SQLite database to data/YYYY-MM-DD.HHMM.dump.sql'
task :dump do
  sqlite = ENV['SQLITE'] || 'sqlite3'
  base_d = File.dirname(__FILE__)
  data_d = base_d + '/data'
  target = File.join(data_d, Time.now.strftime("%Y-%m-%dT%H%M%Z.dump.sql"))
  db     = ENV['DB'] || File.join(base_d, 'GrizSpace/GrizSpaceDB.sqlite')

  abort "#{db} does not exist" unless File.exists?(db)
  sh "#{sqlite} #{db} .dump > #{target}"

  if $?.success? and File.exists?(target)
    STDERR.puts "Dumped to #{target}"
  end
end
