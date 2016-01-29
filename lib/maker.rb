require 'cmdlib'
require 'maker/templates'
require 'maker/version'
require 'maker/utils'
require 'maker/env'
require 'maker/cmdlist'
require 'maker/application'
require 'maker/make'

module Maker
  # Global context.
  @@context = {
    :rundir  => '',
    :curdir  => '',
    :profile => 'profile.rb',
  }
  # CLI options.
  @@options = {
    :version   => nil,
    :verbose   => nil,
    # for 'Maker cmd' only.
    :loopmode => nil,
  }
end
