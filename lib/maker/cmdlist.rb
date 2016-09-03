require "erb"

module Maker
  
  PROFILE = {
    # project directory tree struct.
    :systree => {
      :app     => 'app',
      :config  => 'config',
      :doc     => 'doc',
      :lib     => 'lib',
      :test    => 'test',
      :tools   => 'tools',
      :vendor  => 'vendor',
      :readme  => 'README.md',
      :license => 'LICENSE.txt',
    },
    # application directory tree struct.
    :apptree => {
      :doc      => 'doc',
      :inc      => 'include',
      :script   => 'script',
      :src      => 'src',
      :makefile => 'Rakefile',
    },
    # templates directory tree struct.
    :cfgtree => {
      :tmp => 'templates',
      :env => 'environments',
      :cfg => 'config.rb'
    },
  }

  class CmdList < Thor
    include Maker
    class_option :verbose, :type => :boolean, :aliases => "-V", :desc => "Verbose log messages to standard output."
    class_option :version, :type => :boolean, :aliases => "-v", :desc => "Display application version to standard output."
    
    
    desc "new [PROJECT-NAME]", "Create project skelet named as PROJECT-NAME"
    # [project]
    #     + [app]
    #     + [config]
    #         + [environments]
    #         + [templates]
    #         - config.rb
    #     + [doc]
    #     + [lib]
    #     + [test]
    #     + [tools]
    #     + [vendor]
    #     - project.rb
    #     - LICENSE.txt
    #     - README.md
    #
    def new( projname )
      # check to already exist project.
      if Dir.exist?( projname ) then
	puts "maker: project '#{projname}' already exist."
	return
      end
      puts "generate project : #{projname} ..."
      # create base directories
      Maker.makedir( projname )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:app]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:config]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:doc]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:lib]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:test]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:tools]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:vendor]}" )
      # create project describe file
      f = File.new( "#{projname}/#{@@context[:profile]}", 'w' )
      #erbout = ERB.new( $tmp_profile, 0, "%<>" )
      require 'maker/templates/project.rb'
      erbout = ERB.new( $tmp_profile, 0, "%<>" )
      f.puts erbout.result
      f.close
      # generate licese for project.
      require 'maker/templates/license.rb'
      print "Do you want use MIT license? [y/n] : "
      loop do
        STDIN.flush
        case STDIN.gets.strip
        when 'y'
          puts "generate MIT license file ..."
          f = File.new( "#{projname}/#{Maker::PROFILE[:systree][:license]}", 'w' )
          erbout = ERB.new( $tmp_license, 0, "%<>" )
          f.puts erbout.result
          f.close
          break
        when 'n'
          break
        else
          puts 'Please type [y/n]'
        end
      end
    end

  end

end # module Maker
