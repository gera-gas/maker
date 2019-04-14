require "erb"

module Maker

  # [project]
  #     + [app]
  #     + [config]
  #         + [environments]
  #         + [templates]
  #         - config.rb
  #     + [doc]
  #     + [common]
  #     + [test]
  #     + [tools]
  #     + [vendor]
  #     - project.rb
  #     - LICENSE.txt
  #     - README.md
  #
  class New < Cmdlib::Command
    include Maker
    def init
      @name = 'new'
      @brief = 'Create a new project directory.'
      @details << 'Project structure:'
      @details << ''
      @details << '[...]'
      @details << " + [#{Maker::PROFILE[:systree][:app]}]"
      @details << " + [#{Maker::PROFILE[:systree][:config]}]"
      @details << " + [#{Maker::PROFILE[:systree][:doc]}]"
      @details << " + [#{Maker::PROFILE[:systree][:common]}]"
      @details << " + [#{Maker::PROFILE[:systree][:test]}]"
      @details << " + [#{Maker::PROFILE[:systree][:tools]}]"
      @details << " + [#{Maker::PROFILE[:systree][:vendor]}]"
      @details << " - #{@@context[:profile]}"
      @details << " - #{Maker::PROFILE[:systree][:readme]}"
      @example << 'maker new [PROJECT-NAME]'
      @argnum = 1
      
      addopt Cmdlib::Option.new( 's', 'silent', 'Silent generation project (no questions asked)' )
    end
    
    def handler( global_options, args )
      projname = args[0]
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
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:common]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:test]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:tools]}" )
      Maker.makedir( "#{projname}/#{Maker::PROFILE[:systree][:vendor]}" )
      # create project describe file
      f = File.new( "#{projname}/#{@@context[:profile]}", 'w' )
      require 'maker/templates/project.rb'
      erbout = ERB.new( $tmp_profile, 0, "%<>" )
      f.puts erbout.result
      f.close
      # generate licese for project.
      if @options[:silent].value == nil then
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
      # set templates and config tree.
      adddir = "#{projname}/#{Maker::PROFILE[:systree][:config]}/#{Maker::PROFILE[:cfgtree][:add]}"
      envdir = "#{projname}/#{Maker::PROFILE[:systree][:config]}/#{Maker::PROFILE[:cfgtree][:env]}"
      tmpdir = "#{projname}/#{Maker::PROFILE[:systree][:config]}/#{Maker::PROFILE[:cfgtree][:tmp]}"
      cfgdir = "#{projname}/#{Maker::PROFILE[:systree][:config]}"
      # generate config subdirectory.
      Maker.makedir( envdir )
      Maker.makedir( tmpdir )
      Maker.makedir( adddir )
      # create global configure file.
      require 'maker/templates/config.rb'
      f = File.new( "#{cfgdir}/#{Maker::PROFILE[:cfgtree][:cfg]}", 'w' )
      $tmp_global_config.each do |line|
        f.puts line
      end
      f.close
      # create example template files.
      require 'maker/templates/tmp_main_hello.rb'
      f = File.new( "#{tmpdir}/main_hello.erb", 'w' )
      $tmp_main.each do |line|
        f.puts line
      end
      f.close
      require 'maker/templates/tmp_main.rb'
      f = File.new( "#{tmpdir}/main.erb", 'w' )
      $tmp_main.each do |line|
        f.puts line
      end
      f.close
      require 'maker/templates/tmp_cpp.rb'
      f = File.new( "#{tmpdir}/src.erb", 'w' )
      $tmp_cpp.each do |line|
        f.puts line
      end
      f.close
      require 'maker/templates/tmp_hpp.rb'
      f = File.new( "#{tmpdir}/hdr.erb", 'w' )
      $tmp_hpp.each do |line|
        f.puts line
      end
      f.close
      # generate readme file for project.
      require 'maker/templates/readme.rb'
      f = File.new( "#{projname}/#{Maker::PROFILE[:systree][:readme]}", 'w' )
      erbout = ERB.new( $tmp_readme, 0, "%<>" )
      f.puts erbout.result
      f.close
      # generate gitignore file for project.
      require 'maker/templates/gitignore.rb'
      f = File.new( "#{projname}/.gitignore", 'w' )
      $tmp_gitignore.each do |line|
        f.puts line
      end
      f.close
      # create environment configure file.
      require 'maker/templates/env_develop.rb'
      f = File.new( "#{envdir}/develop.rb", 'w' )
      $env_develop.each do |line|
        f.puts line
      end
      f.close
      require 'maker/templates/env_production.rb'
      f = File.new( "#{envdir}/production.rb", 'w' )
      $env_production.each do |line|
        f.puts line
      end
      f.close
      require 'maker/templates/env_test.rb'
      f = File.new( "#{envdir}/test.rb", 'w' )
      $env_test.each do |line|
        f.puts line
      end
      f.close
    end

  end

end # module Maker
