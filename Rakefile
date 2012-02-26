require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rake/packagetask'
require 'rdoc/task'

desc "package the gem"
task :package do
  system 'gem build gbarcode.gemspec'
end

desc "Run test code"
Rake::TestTask.new(:test) do |t|
  ["ext", "lib", "test"].each {|lib| t.libs << lib}
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc "Create documentation"
Rake::RDocTask.new(:docs) do |rd|
  rd.main = "README.txt"
  rd.rdoc_files.include("./*.txt")
  rd.options =  RDOC_OPTS
end

desc "Makes the Makefile"
task :extconf do 
  system 'cd ext/; ruby extconf.rb'
end

desc "Compiles extensions"
task :compile => [:extconf] do 
  system 'cd ext/; make'
end

# add compiled files to clean list
CLOBBER << FileList["ext/**/*.o", "ext/Makefile"]
