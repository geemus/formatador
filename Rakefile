require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "formatador"
    gem.summary = %Q{Ruby STDOUT text formatting}
    gem.description = %Q{STDOUT text formatting}
    gem.email = "wbeary@engineyard.com"
    gem.homepage = "http://github.com/geemus/formatador"
    gem.authors = ["Wesley Beary"]
    # gem.add_development_dependency "shindo", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'shindo/rake'
Shindo::Rake.new

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |tests|
    tests.libs << 'tests'
    tests.pattern = 'tests/**/*_tests.rb'
    tests.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :tests => :check_dependencies

task :default => :tests

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "formatador #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
