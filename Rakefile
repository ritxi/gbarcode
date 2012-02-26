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

### Win32 Packages ###

Win32Spec = SPEC.dup
Win32Spec.platform = 'x86-mswin32'
Win32Spec.files = PKG_FILES + ['lib/hpricot_scan.so']
Win32Spec.extensions = []
  
WIN32_PKG_DIR = "#{PKG}-mswin32"

desc "Package up the Win32 distribution."
file WIN32_PKG_DIR => [:package] do
  sh "tar zxf pkg/#{PKG}.tgz"
  mv PKG, WIN32_PKG_DIR
end

desc "Cross-compile the hpricot_scan extension for win32"
file "hpricot_scan_win32" => [WIN32_PKG_DIR] do
  cp "extras/mingw-rbconfig.rb", "#{WIN32_PKG_DIR}/ext/hpricot_scan/rbconfig.rb"
  sh "cd #{WIN32_PKG_DIR}/ext/hpricot_scan/ && ruby -I. extconf.rb && make"
  mv "#{WIN32_PKG_DIR}/ext/hpricot_scan/hpricot_scan.so", "#{WIN32_PKG_DIR}/lib"
end

desc "Build the binary RubyGems package for win32"
task :package_win32 => ["hpricot_scan_win32"] do
  Dir.chdir("#{WIN32_PKG_DIR}") do
    Gem::Builder.new(Win32Spec).build
    verbose(true) {
      mv Dir["*.gem"].first, "../pkg/#{WIN32_PKG_DIR}.gem"
    }
  end
end

CLEAN.include WIN32_PKG_DIR

### end WIN32 ###

# add compiled files to clean list
CLOBBER << FileList["ext/**/*.o", "ext/Makefile"]
