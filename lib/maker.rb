require 'os'
require 'cmdlib'
require 'maker/version'
require 'maker/utils'
require 'maker/commands/new'
require 'maker/commands/app'
require 'maker/commands/addon.rb'
require 'maker/commands/gen.rb'
require 'maker/commands/cfg.rb'
require 'maker/application'

module Maker
  
  # Global context for all commands.
  # :curdir contain path to found project.
  @@context = {
    :rundir  => '',
    :curdir  => '',
    :profile => 'profile.rb',
    :maker   => File.dirname(__FILE__),
    :project => '',
  }
  
  PROFILE = {
    # project directory tree struct.
    :systree => {
      :app     => 'app',
      :config  => 'config',
      :doc     => 'doc',
      :common  => 'common',
      :test    => 'test',
      :tools   => 'tools',
      :vendor  => 'vendor',
      :readme  => 'README.md',
      :license => 'LICENSE.txt',
    },
    # application directory tree struct.
    :apptree => {
      :doc     => 'doc',
      :script  => 'script',
      :source  => 'source',
    },
    # templates directory tree struct.
    :cfgtree => {
      :add => 'addons',
      :tmp => 'templates',
      :env => 'environments',
      :in  => 'configure_in',
      :cfg => 'config.rb'
    },
  }

end
