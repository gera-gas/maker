require "erb"

module Maker

  # Create application for found project.
  class App < Cmdlib::Command
    include Maker
    def init
      @name = 'app'
      @brief = 'Create a new application.'
      @details << 'Find project root, read application structure from profile'
      @details << 'and generate application tree.'
      @example << 'maker app [APPLICATION-NAME]'
      @argnum = 1
    end
    
    def handler( global_options, args )
      # check result of project searching.
      if @@context[:project] == '' then
	puts 'error: unable to execute this command outside of project.'
	return
      end
      appname = args[0]
      apppath = $project[:systree][:app]
      # check to already exist project.
      if Dir.exist?( "#{apppath}/#{appname}" ) then
	puts "maker: application '#{appname}' already exist."
	return
      end
      puts "generate application : #{appname} ..."
      # create base directories
      Maker.makedir( "#{apppath}/#{appname}" )
      Maker.makedir( "#{apppath}/#{appname}/#{$project[:apptree][:doc]}" )
      Maker.makedir( "#{apppath}/#{appname}/#{$project[:apptree][:inc]}" )
      Maker.makedir( "#{apppath}/#{appname}/#{$project[:apptree][:script]}" )
      Maker.makedir( "#{apppath}/#{appname}/#{$project[:apptree][:src]}" )
    end

  end

end # module Maker
