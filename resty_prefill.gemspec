$:.push File.dirname(__FILE__) + '/lib'
require 'resty_prefill/version'

Gem::Specification.new do |s|
  s.name = "resty_prefill"
  s.version = RestyPrefill::VERSION
  s.date = "2013-03-10"

  s.summary = "Used to preserve RESTful URLs despite form submit errors."
  s.description = "Used to preserve RESTful URLs despite form submit errors."

  s.authors = ["Paul A. Jungwirth"]
  s.homepage = "http://github.com/pjungwir/resty_prefill"
  s.email = "pj@illuminatedcomputing.com"

  s.licenses = ["MIT"]

  s.require_paths = ["lib"]
  s.executables = []
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,fixtures}/*`.split("\n")

  s.add_runtime_dependency 'rails', '>= 3.0.0'
  s.add_development_dependency 'rspec', '~> 2.4.0'
  s.add_development_dependency 'bundler', '>= 0'

end

