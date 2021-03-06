# -*- encoding: utf-8 -*- 
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "simple_eav"
  s.version     = SimpleEav::VERSION
  s.authors     = ["Tim Linquist"]
  s.email       = ["tim.linquist@gmail.com"]
  s.homepage    = %q{http://github.com/timlinquist/simple_eav}
  s.summary     = %q{A simple alternative to acts_as_eav_model.}
  s.description = %q{A simple alternative to acts_as_eav_model that works with ActiveRecord without any monkey patching needed.  Acts_as_eav_model's gives a model the ability to have any number of custom attributes.  This project has the same goal.  The difference being maintaining utmost compatability with ActiveRecord::Base.}

  s.files            = [".gitignore", ".rvmrc", ".travis.yml", "Gemfile", "LICENSE", "README.rdoc", "Rakefile", "lib/simple_eav.rb", "lib/version.rb", "simple_eav.gemspec", "spec/db/schema.rb", "spec/lib/simple_eav_spec.rb", "spec/spec_helper.rb", "spec/support/child.rb", "spec/support/person.rb"]
  s.test_files       = ["spec/db/schema.rb", "spec/lib/simple_eav_spec.rb", "spec/spec_helper.rb", "spec/support/child.rb", "spec/support/person.rb"]
  s.executables      = []
  s.extra_rdoc_files = [ "README.rdoc" ]
  s.require_path     = "lib"

  s.add_dependency 'activerecord', '>= 3.1'
  unless ENV["CI"]
    if RUBY_VERSION <= '1.9.1'
      s.add_development_dependency 'ruby-debug'
    else
      s.add_development_dependency 'ruby-debug19'
    end
  end
  s.add_development_dependency 'sqlite3', '>= 1.3.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '>= 2.6.0'
end
