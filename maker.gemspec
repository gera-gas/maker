# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maker/version'

Gem::Specification.new do |spec|
  spec.name          = "maker"
  spec.version       = Maker::VERSION
  spec.authors       = ["Anton S. Gerasimov"]
  spec.email         = ["gera_box@mail.ru"]

  spec.summary       = %q{C/C++ embedded software framefork.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/gera-gas/maker"
  spec.license       = "MIT"
  spec.files         = ["lib/maker.rb",
                        "lib/maker/version.rb",
                        "lib/maker/application.rb",
                        "lib/maker/commands/new.rb",
                        "lib/maker/commands/app.rb",
                        "lib/maker/commands/addon.rb",
                        "lib/maker/commands/gen.rb",
                        "lib/maker/utils.rb",
                        "lib/maker/templates/addons.rb",
                        "lib/maker/templates/project.rb",
                        "lib/maker/templates/license.rb",
                        "lib/maker/templates/config.rb",
                        "lib/maker/templates/tmp_main_hello.rb",
                        "lib/maker/templates/tmp_main.rb",
                        "lib/maker/templates/tmp_cpp.rb",
                        "lib/maker/templates/tmp_hpp.rb",
                        "lib/maker/templates/readme.rb",
                        "lib/maker/templates/gitignore.rb",
                        "lib/maker/templates/env_develop.rb",
                        "lib/maker/templates/env_test.rb",
                        "lib/maker/templates/env_production.rb",
                     ]
  spec.bindir        = "bin"
  spec.executables   = "maker"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  
  #spec.add_dependency "indent_code", ">= 0.1.5"
  spec.add_dependency "cmdlib", "~> 1.0.0"
  spec.add_dependency "os", "~> 0.9.6"
  #spec.add_dependency "thor", "~> 0.19.1"  
end
