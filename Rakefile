require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  exec "irb -rubygems -I lib -r laziness.rb"
end
