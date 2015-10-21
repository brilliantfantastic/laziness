# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'laziness/version'

Gem::Specification.new do |spec|
  spec.name          = "laziness"
  spec.version       = Slack::VERSION
  spec.authors       = ["Jamie Wright"]
  spec.email         = ["jamie@brilliantfantastic.com"]
  spec.summary       = "A Slack API wrapper written in Ruby."
  spec.description   = "Laziness wraps the Slack API in a Ruby gem so Ruby programs can easily communicate with the Slack API (http://api.slack.com)."
  spec.homepage      = "http://github.com/brilliantfantastic/laziness"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency('eventmachine')
  spec.add_runtime_dependency('faye-websocket', '>= 0.8.0')
  spec.add_runtime_dependency('hashie')
  spec.add_runtime_dependency('httparty')
  spec.add_runtime_dependency('multi_json')
end
