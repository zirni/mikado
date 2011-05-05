require 'bundler'
Bundler::GemHelper.install_tasks

desc "run tests"
task :default do
  unless File.exists?('test/db/test.sqlite3')
    puts "Database doesn't exists"
    puts "run rake db:test:prepare"
    exit
  end
  
  Dir['test/*_test.rb'].each do |file|
    require file
  end
end

namespace :db do
  namespace :test do
    desc "create and prepare test database"
    task :prepare do
      Dir.mkdir('test/db') unless File.directory?('test/db')
      require 'test/prepare'
    end
    
    desc "delete test database"
    task :delete do
      FileUtils.rm_rf('test/db')
    end
  end
end