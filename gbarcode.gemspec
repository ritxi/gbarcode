# -*- encoding: utf-8 -*-
require 'rubygems/package_task'
$:.push File.expand_path("../ext", __FILE__)



Gem::Specification.new do |s|
  s.name = "gbarcode"
  s.version = "0.98"
  s.summary = "A C extension that wraps the GNU Barcode project."
  s.description = s.summary + " For more Ruby-ish syntax, you should use the Rbarcode gem."
  s.author = "Angel Pizarro"
  s.email = "angel@delagoya.com"
  s.homepage = "http://gbarcode.rubyforge.org"
  s.test_files = FileList['test/**/*']
  s.files = FileList['*.txt', 'doc/**/*.*', 'ext/**/*.c', 'ext/**/*.h', 'ext/**/*.rb', 'gbarcode.gemspec']
  s.require_paths = [".","ext"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = FileList['*.txt']
  s.has_rdoc = true
  s.rdoc_options = ["--exclude", "\.c$"]
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.8.4"
  s.rubyforge_project = "gbarcode"
end