require "erb"

module Maker

  # Handler of 'project' command.
  # Project directory skelet:
  #
  # [project]
  #     + [app]
  #     + [config]
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
  class CLIproject < Cmdlib::Command
    include Maker
    # Redefine default handler.
    def handler
      projectname = ARGV[1]
      # check to already exist project.
      if Dir.exist?( projectname ) then
	puts "maker: project '#{projectname}' already exist."
	return
      end
      puts "generate project : #{projectname} ..."
      # create base directories
      Maker.makedir( projectname )
      Maker.makedir( projectname + '/app' )
      Maker.makedir( projectname + '/config' )
      Maker.makedir( projectname + '/doc' )
      Maker.makedir( projectname + '/lib' )
      Maker.makedir( projectname + '/test' )
      Maker.makedir( projectname + '/tools' )
      Maker.makedir( projectname + '/vendor' )
      # create project describe file
      profile = {
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
        :gentree => {
          :template => 'templates',
        },
        # config directory tree struct.
        :cfgtree => {
          :file => 'config.rb',
        },
      }
      f = File.new( "#{projectname}/#{@@context[:profile]}", 'w' )
      f.puts '# This is project struct file.'
      f.puts '# You can prcessing carefully modify this fields,'
      f.puts '# but do not rename map variables.'
      f.puts '# '
      f.puts '# ' + Time.now.to_s
      f.puts '$project = {'
      f.puts "  :name => '#{projectname}',"
      f.puts '  # project directory tree struct.'
      f.puts '  :systree => {'
      f.puts "    :app     => '#{profile[:systree][:app]}',"
      f.puts "    :config  => '#{profile[:systree][:config]}',"
      f.puts "    :doc     => '#{profile[:systree][:doc]}',"
      f.puts "    :lib     => '#{profile[:systree][:lib]}',"
      f.puts "    :test    => '#{profile[:systree][:test]}',"
      f.puts "    :tools   => '#{profile[:systree][:tools]}',"
      f.puts "    :vendor  => '#{profile[:systree][:vendor]}',"
      f.puts "    :readme  => '#{profile[:systree][:readme]}',"
      f.puts "    :license => '#{profile[:systree][:license]}',"
      f.puts '  },'
      f.puts '  # application directory tree struct.'
      f.puts '  :apptree => {'
      f.puts "    :doc      => '#{profile[:apptree][:doc]}',"
      f.puts "    :inc      => '#{profile[:systree][:app]}',"
      f.puts "    :script   => '#{profile[:apptree][:script]}',"
      f.puts "    :src      => '#{profile[:apptree][:src]}',"
      f.puts "    :makefile => '#{profile[:apptree][:makefile]}',"
      f.puts '  },'
      f.puts '  # templates directory tree struct.'
      f.puts '  :gentree => {'
      f.puts "    :template => '#{profile[:gentree][:template]}',"
      f.puts '  },'
      f.puts '  # config directory tree struct.'
      f.puts '  :cfgtree => {'
      f.puts "    :file => '#{profile[:cfgtree][:file]}',"
      f.puts '  },'
      f.puts '  # config GNU GCC descriptors.'
      f.puts '  :gcc => {'
      f.puts "    :cc => '',"
      f.puts "    :makelist => [],"
      f.puts '  },'
      f.puts '}'
      f.close
      # generate licese for project.
      print "Do you want use MIT license? [y/n] : "
      loop do
        STDIN.flush
        case STDIN.gets.strip
        when 'y'
          puts "generate MIT license file ..."
          erbout = ERB.new( $tmp_license, 0, "%<>" )
          f = File.new( projectname + '/LICENSE.txt', 'w' )
          f.puts erbout.result
=begin
          f.puts 'The MIT License (MIT)'
          f.puts ''
          f.puts "Copyright (c) #{Time.now.to_s[0,4]} #{ENV['USER']}"
          f.puts ''
          f.puts 'Permission is hereby granted, free of charge, to any person obtaining a copy'
          f.puts 'of this software and associated documentation files (the "Software"), to deal'
          f.puts 'in the Software without restriction, including without limitation the rights'
          f.puts 'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'
          f.puts 'copies of the Software, and to permit persons to whom the Software is'
          f.puts 'furnished to do so, subject to the following conditions:'
          f.puts ''
          f.puts 'The above copyright notice and this permission notice shall be included in'
          f.puts 'all copies or substantial portions of the Software.'
          f.puts ''
          f.puts 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'
          f.puts 'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'
          f.puts 'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'
          f.puts 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'
          f.puts 'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'
          f.puts 'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN'
          f.puts 'THE SOFTWARE.'
=end
          f.close
          break
        when 'n'
          break
        else
          puts 'Please type [y/n] only ...'
        end
      end
      # set templates and config tree.
      tmpdir = "#{projectname}/#{profile[:systree][:config]}/#{profile[:gentree][:template]}"
      cfgdir = "#{projectname}/#{profile[:systree][:config]}"
      # generate templates and config tree.
      Maker.makedir( tmpdir )
      Maker.makedir( cfgdir )
      # create global configure file.
      f = File.new( "#{cfgdir}/#{profile[:cfgtree][:file]}", 'w' )
      f.puts '# Global configuration script.'
      f.puts "require 'maker'"
      f.puts ""
      f.puts "# Write you setting for each OS types."
      f.puts "case Maker.ostype"
      f.puts "when 'win32'"
      f.puts "  # TODO: only for Windows famaly (32 bitness)."
      f.puts "when 'win64'"
      f.puts "  # TODO: only for Windows famaly (64 bitness)."
      f.puts "when 'unix'"
      f.puts "  # TODO: only for Unix famaly."
      f.puts "end"
      f.puts ""
      f.puts "# Global config variables."
      f.puts "$global = {"
      f.puts "  # Templates setting for 'gen' command."
      f.puts "  :gen => {"
      f.puts "    :src => ['.c', '.cc', '.cpp', '.c++', '.cxx'],"
      f.puts "    :hdr => ['.h', '.hpp', '.hxx'],"
      f.puts "  },"
      f.puts "}"
      f.close
      # create example template files.
      f = File.new( "#{tmpdir}/main.c.erb", 'w' )
      f.puts '/**'
      f.puts " *  @file  <%= ARGV[1] %>"
      f.puts ' *  @date  <%= Time.now %>'
      f.puts ' *  @brief Entry point to program.'
      f.puts ' */'
      f.puts '#include <stdlib.h>'
      f.puts ''
      f.puts 'int main ( int argc, char* argv[] )'
      f.puts '{'
      f.puts '    return 0;'
      f.puts '}'
      f.close
      f = File.new( "#{tmpdir}/cpp.erb", 'w' )
      f.puts '/**'
      f.puts ' *  @file  <%= ARGV[1] %>'
      f.puts ' *  @date  <%= Time.now %>'
      f.puts ' */'
      f.close
      f = File.new( "#{tmpdir}/hpp.erb", 'w' )
      f.puts '<% headername = ARGV[1].upcase.gsub(?.,?_) %>'
      f.puts "#ifndef <%= headername %>"
      f.puts "#define <%= headername %>"
      f.puts '/**'
      f.puts ' *  @file  <%= ARGV[1] %>'
      f.puts ' *  @date  <%= Time.now %>'
      f.puts ' */'
      f.puts '#ifdef __cplusplus'
      f.puts 'extern "C" {'
      f.puts '#endif'
      f.puts ''
      f.puts '#ifdef __cplusplus'
      f.puts '}'
      f.puts '#endif'
      f.puts ''
      f.puts '#endif /* <%= headername %> */'
      f.close
      # generate readme file for project.
      f = File.new( projectname + '/README.md', 'w' )
      f.puts "# #{projectname}"
      f.puts 'TODO: describe your project...'
      f.puts ''
      f.puts "# Project Tree"
      f.puts '* [app]       -- project target applications.'
      f.puts '* [config]    -- directory with configuration files and templates.'
      f.puts '* [doc]       -- directory with documentation on source code.'
      f.puts '* [lib]       -- library applications.'
      f.puts '* [test]      -- contain complex and finally tests for project.'
      f.puts '* [tools]     -- utilites and tools for project.'
      f.puts '* [vendor]    -- third-party source code.'
      f.puts '* project.rb  -- project structuries file in Ruby language.'
      f.puts '* LICANSE.txt -- file with licese information.'
      f.puts '* README.md   -- Readme file in markdown style.'
      f.close
      # generate gitignore file for project.
      f = File.new( projectname + '/.gitignore', 'w' )
      f.puts "*.[oad]"
      f.puts "*.elf"
      f.puts "*.exe"
      f.puts "*~"
      f.puts "*.rc2"
      f.puts "*.bmp"
      f.puts "*.log"
      f.puts "*.map"
      f.puts "*.cbp"
      f.puts "*.workspace"
      f.puts "*.layout"
      f.puts "*.ini"
      f.puts "*.ico"
      f.puts "*.bak"
      f.close
    end
  end


  # Handler of 'app' command.
  # Application directory skelet:
  #
  # [app]
  #     + [include]
  #     + [script]
  #     + [src]
  #     - Rakefile
  #
  class CLIapp < Cmdlib::Command
    include Maker
    # Redefine default handler.
    def handler
      Maker.findproject
      # name application name.
      appname = "#{$project[:systree][:app]}/#{ARGV[1]}"
      # check to already exist application.
      if Dir.exist?( appname ) then
	puts "maker: application '#{appname}' already exist."
	return
      end
      puts "generate application : #{appname} ..."
      # create base directories
      Maker.makedir( appname )
      Maker.makedir( appname + '/include' )
      Maker.makedir( appname + '/script' )
      Maker.makedir( appname + '/src' )
      # create local (application) configure file.
      f = File.new( appname + '/app.rb', 'w' )
      f.puts '# Local configuration script for this application only.'
      f.puts '# Configure your application here...'
      f.puts ""
      f.puts "# Write you setting for each OS types."
      f.puts "case Maker.ostype"
      f.puts "when 'win32'"
      f.puts "  # TODO: only for Windows famaly (32 bitness)."
      f.puts "when 'win64'"
      f.puts "  # TODO: only for Windows famaly (64 bitness)."
      f.puts "when 'unix'"
      f.puts "  # TODO: only for Unix famaly."
      f.puts "end"
      f.close
      # create Rakefile.
      f = File.new( appname + '/Rakefile', 'w' )
      f.puts "require '../../profile.rb'"
      f.puts "require '../../config/config.rb'"
      f.puts "require './app.rb'"
      f.close
    end
  end


  # Generate template for source file.
  class CLIgen < Cmdlib::Command
    include Maker
    # Redefine default handler.
    def handler
      Maker.findproject
      # set variables.
      srcname = ARGV[1]
      tmpdir = "#{$project[:systree][:config]}/#{$project[:gentree][:template]}"
      # First step => find template by name.
      # template name = <filename> + .erb
      tfile = "#{tmpdir}/#{srcname}.erb"
      flist = Maker.findfiles( tmpdir, "#{srcname}.erb" )
      # Second step => find template by extention.
      # template name = <filename> + .erb
      if !flist.include?( tfile ) then
        $global[:gen].each do |pair|
          if pair.last.include?( File.extname(srcname) ) then
            tfile = "#{tmpdir}/#{pair.first}.erb"
            break
          end
        end
      end
      # Run ERB for source file generation.
      if File.exist? tfile then
        Maker.verbose "generate file from: '#{tfile}' to '#{srcname}'"
        # create output file.
        f = File.new( "#{@@context[:rundir]}/#{srcname}", 'w' )
        # read template file.
        lines = %q{}
        File.open( tfile, 'r' ).each do |line|
          lines << line
        end
        # output result of parsing.
        erbout = ERB.new( lines, 0, "%<>" )
        f.puts erbout.result
        f.close
      end
    end
  end


  # Execute OS CLI command in project environment.
  class CLIcmd < Cmdlib::Command
    include Maker
    # Redefine default handler.
    def handler
    Maker.findproject
    if @@options[:verbose].value != nil then
      puts
      puts '** ENVIRONMENT:'
      ENV['PATH'].split(Maker::Env.delimitter).each do |env|
        puts env
      end
      puts
      puts '** USER COMMAND:'
    end
    print "#{$project[:name]}$ "
    STDIN.flush
    oscmd = STDIN.gets.strip
    puts `#{oscmd}` if !oscmd.empty?
    end
  end

end # module Maker
