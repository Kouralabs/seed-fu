# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'seed-fu/version'

def latest_sqlite3?
  rails_version = ENV['RAILS_VERSION']

  return true if rails_version.nil? || rails_version == 'head'

  Gem::Version.new(rails_version) >= Gem::Version.new('6.0.0')
end

Gem::Specification.new do |s|
  s.name        = 'seed-fu'
  s.version     = SeedFu::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ['Michael Bleigh', 'Jon Leighton']
  s.email       = ['michael@intridea.com', 'j@jonathanleighton.com']
  s.homepage    = 'http://github.com/mbleigh/seed-fu'
  s.summary     = 'Easily manage seed data in your Active Record application'
  s.description = 'Seed Fu is an attempt to once and for all solve the problem of inserting and maintaining seed data in a database. It uses a variety of techniques gathered from various places around the web and combines them to create what is hopefully the most robust seed data system around.'

  s.add_dependency 'activerecord', ['>= 3.1']
  s.add_dependency 'activesupport', ['>= 3.1']

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec', '~> 3.9'

  rails_version = ENV['RAILS_VERSION']

  if latest_sqlite3?
    s.add_development_dependency 'sqlite3'
  else
    # sqlite3 1.4.0 does not work with older versions
    # of rails and the gemfiles don't specify the version,
    # so we lock an older version for older rails versions
    s.add_development_dependency 'sqlite3', '~> 1.3.6'
  end

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.require_path = 'lib'
end
