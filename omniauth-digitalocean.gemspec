lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-digitalocean/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-digitalocean"
  spec.version       = Omniauth::Digitalocean::VERSION
  spec.authors       = ["DigitalOcean API Engineering team"]
  spec.email         = ["api-engineering@digitalocean.com"]
  spec.summary       = %q{Official OmniAuth strategy for Digitalocean}
  spec.description   = %q{Official OmniAuth strategy for Digitalocean}
  spec.homepage      = "https://github.com/digitalocean/omniauth-digitalocean"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 2.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.0"
  spec.add_dependency "multi_json", '~> 1.15'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.7"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
end
