module Maker

  class Application
    include Maker

    def initialize
      # Create application.
      @app = Cmdlib::App.new( 'maker' )
      @app.about << 'C/C++ embedded software framefork'
      # Add options to application.
      @app.addopt Cmdlib::Option.new( 'v', 'verbose', 'Option enable verbose statistic.' )
      # Add commands to application.
      @app.addcmd New.new
      @app.addcmd App.new
      @app.addcmd Addon.new
      # Search project environment.
      if Maker.findproject then
	@@context[:project] = @@context[:curdir]	
        # Add custom commands from addons of found project.
	require 'find'
	Find.find( "#{$project[:systree][:config]}/#{$project[:cfgtree][:add]}" ) do |path|
	  if path =~ /^[\w\/]+\.rb$/ then
	    require "./#{path}"
	    eval("@app.addcmd #{Maker.toclass(File.basename(path).split('.')[0])}.new")
	  end
	end
      else
	Dir.chdir( @@context[:rundir] )
      end
      # Start application.
      @app.run
    end
    
  end # class Application
end # module Maker
