require 'cmdlib'
require 'maker/templates'
require 'maker/version'
require 'maker/utils'
require 'maker/env'
require 'maker/cmdlist'
require 'maker/application'

#require './maker/version.rb'
#require './maker/utils.rb'
#require './maker/cmdlist.rb'
#require './maker/application.rb'

module Maker
  # Global context.
  @@context = {
    :rundir  => '',
    :curdir  => '',
    :profile => 'profile.rb',
  }
  # CLI options.
  @@options = {
    :version => nil,
    :verbose => nil,
  }
end

#Maker::Application.new.run
