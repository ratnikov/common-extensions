# encoding: utf-8

require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |task|
  task.libs << "lib"
  task.libs << "test"
  task.pattern = "test/**/*_test.rb"
  task.verbose = false
end

desc "Run the test suite"
task :default => ['test']

gem_spec = Gem::Specification.new do |gem_spec|
  gem_spec.name        = "common-extensions"
  gem_spec.version     = "0.1"
  gem_spec.summary     = "Commonly used extensions bunched up together"
  gem_spec.email       = "dmitryr@webitects.com"
  gem_spec.homepage    = "http://github.com/ratnikov/common-extensions"
  gem_spec.description = "Commonly used extensions bunched up together"
  gem_spec.authors     = [ "Dmitry Ratnikov" ]
  gem_spec.files       = FileList["[A-Z]*", "{lib}/**/*"]
end

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{gem_spec.name}.gemspec", 'w') do |f|
    f.write gem_spec.to_yaml
  end
end

