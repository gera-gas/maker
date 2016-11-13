require "erb"

module Maker

  # Generate source file from project termplates.
  class Gen < Cmdlib::Command
    include Maker
    def init
      @name = 'gen'
      @brief = 'Generate source file from project termplates.'
      @example << '$ cd <Your path to maker project>'
      @example << '$ maker gen test.h'
      @example << '$ cat test.h'
      @example << ''
      @example << '#ifndef TEST_H'
      @example << '#define TEST_H'
      @example << '/**'
      @example << ' *  @file  test.h'
      @example << ' *  @date  2014-09-08 10:54:18'      
      @example << ' */'
      @example << '#endif /* TEST_H */'
      @argnum = 1
      
      addopt Cmdlib::Option.new( 't', 'template', 'Set template file.', true )
    end
    
    def handler( global_options, args )
      # check result of project searching.
      if @@context[:project] == '' then
        puts 'error: unable to execute this command outside of project.'
        return
      end
      outname = args[0]
      tmpfile = ''
      if @options[:template].value != nil then
        if $global_config[:gen].keys.include?( @options[:template].value.to_sym ) then
          tmpfile = "#{$project[:systree][:config]}/#{$project[:cfgtree][:tmp]}/#{@options[:template].value}.erb"
        else
          puts "error: unable to find template with name '#{@options[:template].value}'."
          return
        end
      # Search template file by extension.
      else
        ext = outname.split('.').last
        $global_config[:gen].each do |e|
          if e[1].include? ext then
            tmpfile = "#{$project[:systree][:config]}/#{$project[:cfgtree][:tmp]}/#{e[0]}.erb"
            break
          end
        end
        if tmpfile == '' then
          puts "error: unable to find template for extension '*.#{ext}'."
          return
        end
      end
      # Output verbose statistic.
      if global_options[:verbose].value != nil
        puts "outfile  : #{outname}"
        puts "template : #{tmpfile}"
      end
      # create output file.
      f = File.new( "#{@@context[:rundir]}/#{outname}", 'w' )
      # read template file.
      lines = %q{}
      File.open( tmpfile, 'r' ).each do |line|
        lines << line
      end
      # output result of parsing.
      erbout = ERB.new( lines, 0, "%<>" )
      f.puts erbout.result
      f.close
    end

  end

end # module Maker
