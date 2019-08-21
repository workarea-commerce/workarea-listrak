#!/usr/bin/env rake
begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Tasker'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"
load "workarea/changelog.rake"

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

task default: :test

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "workarea/listrak/version"

desc "Release version #{Workarea::Listrak::VERSION} of the gem"
task :release do
  host = "https://#{ENV['BUNDLE_GEMS__WEBLINC__COM']}@gems.weblinc.com"

  #Rake::Task['workarea:changelog'].execute
  #system 'git add CHANGELOG.md'
  #system 'git commit -m "Update CHANGELOG"'
  #system 'git push origin HEAD'

  system "git tag -a v#{Workarea::Listrak::VERSION} -m 'Tagging #{Workarea::Listrak::VERSION}'"
  system "git push --tags"

  system "gem build workarea-listrak.gemspec"
  system "gem push workarea-listrak-#{Workarea::Listrak::VERSION}.gem"
  system "gem push workarea-listrak-#{Workarea::Listrak::VERSION}.gem --host #{host}"
  system "rm workarea-listrak-#{Workarea::Listrak::VERSION}.gem"
end
