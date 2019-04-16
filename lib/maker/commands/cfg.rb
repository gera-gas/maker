require "erb"

module Maker

  # Create application for found project.
  class Cfg < Cmdlib::Command
    include Maker
    def init
      @name = 'cfg'
      @brief = 'Start configuring sources from input *.in files.'
      @details << 'Parse all files from [config]/[configure_in] files with extension *.in'
      @details << 'Result will be save in [common]/[generated].'
      @details << 'For more information see gem: ccfg.'
      @example << 'maker cfg'
      @argnum = 0
    end
    
    def handler( global_options, args )
      # check result of project searching.
      if @@context[:project] == '' then
        puts 'error: unable to execute this command outside of project.'
        return
      end
      Maker.configure
    end
  end
  
end # module Maker
