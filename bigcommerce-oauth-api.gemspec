require File.expand_path('../lib/bigcommerce-oauth-api/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'bigcommerce-oauth-api'
  s.version     = BigcommerceOAuthAPI::VERSION.dup
  s.date        = '2014-11-10'
  s.summary     = "Ruby wrapper for the Bigcommerce REST API using OAuth"
  s.description = "Connect Ruby applications with the Bigcommerce REST API using OAuth"
  s.authors     = ["Christian Orthmann"]
  s.email       = 'christian.orthmann@gmail.com'
  s.require_path = 'lib'
  s.files       = `git ls-files`.split("\n") - %w(.rvmrc .gitignore)
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n") - %w(.rvmrc .gitignore)
  s.homepage    = 'http://rubygems.org/gems/bigcommerce-oauth-api'
  s.license     = 'MIT'

  s.add_development_dependency('rake', '~> 10')
  s.add_development_dependency('rspec', '~> 3')
  s.add_development_dependency('webmock', '~> 1')
  s.add_development_dependency('simplecov', '~> 0')
  s.add_development_dependency('simplecov-rcov', '~> 0')
  s.add_runtime_dependency('faraday', '~> 0')
  s.add_runtime_dependency('faraday_middleware', '~> 0')
  s.add_runtime_dependency('activesupport', '>= 3.0.0', '< 5.0.0')
end