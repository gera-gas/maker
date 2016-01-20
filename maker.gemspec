# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maker/version'

Gem::Specification.new do |spec|
  spec.name          = "maker"
  spec.version       = Maker::VERSION
  spec.authors       = ["Anton S. Gerasimov"]
  spec.email         = ["gera_box@mail.ru"]

  spec.summary       = %q{Full-stack C/C++ software framefork application.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/gera-gas/maker"
  spec.license       = "MIT"
  spec.files         = ["lib/maker.rb", "lib/maker/version.rb", "lib/maker/utils.rb", "lib/maker/cmdlist.rb", "lib/maker/application.rb", "lib/maker/env.rb", "lib/maker/templates.rb"]
  spec.bindir        = "bin"
  spec.executables   = "maker"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  
  spec.add_dependency "indent_code", ">= 0.1.5"
  spec.add_dependency "cmdlib", ">= 0.1.1"
end
