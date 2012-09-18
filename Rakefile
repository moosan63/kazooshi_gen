# coding: utf-8
require "rspec/core/rake_task"

desc "run spec"
task :default => [:spec]

RSpec::Core::RakeTask.new(:spec) do |spec|
  # - (Object) pattern
  # default:   'spec/**/*_spec.rb'

  # - (Object) rspec_opts=(opts) 
  # default : nil
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = %w(-c -fs)
end