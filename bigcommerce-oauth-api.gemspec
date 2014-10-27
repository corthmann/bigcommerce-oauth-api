Gem::Specification.new do |s|
  s.name        = 'bigcommerce-oauth-api'
  s.version     = '0.0.1'
  s.date        = '2014-10-26'
  s.summary     = ""
  s.description = ""
  s.authors     = ["Christian Orthmann"]
  s.email       = 'christian.orthmann@gmail.com'
  s.require_path = 'lib'
  s.homepage    = 'http://rubygems.org/gems/bigcommerce-oauth-api'
  s.license     = 'MIT'

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('webmock')
  s.add_development_dependency('simplecov')
  s.add_runtime_dependency('faraday')
  s.add_runtime_dependency('faraday_middleware')
end