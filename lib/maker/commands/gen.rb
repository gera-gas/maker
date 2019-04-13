require "erb"

module Maker

  # Generate source file from project templates.
  class Gen < Cmdlib::Command
    include Maker
    def init
      @name = 'gen'
      @brief = 'Generate source file from project templates.'
      @details << "You can set template file (<your project>/config/templates) by option -t."
      @details << 'For example: maker gen main.c -t main_hello'
      @details << 'For generate module (pair files - *.c and *.h) just skip file extension.'
      @details << 'For example: maker gen mymodule'
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
      outname  = args[0]
      tmpfile  = []
      outfiles = []
      if @options[:template].value != nil then
        if $global_config[:gen].keys.include?( @options[:template].value.to_sym ) then
          tmpfile << "#{$project[:systree][:config]}/#{$project[:cfgtree][:tmp]}/#{@options[:template].value}.erb"
          outfiles << outname
        else
          puts "error: unable to find template with name '#{@options[:template].value}'."
          return
        end
      # Search template file by extension.
      else
      	extension = []
      	if File.extname(outname) == "" then
      	  extension << 'c'
      	  extension << 'h'
      	else
      	  extension << outname.split('.').last
      	end
        extension.each do |ext|
          $global_config[:gen].each do |e|
            if e[1].include? ext then
              tmpfile << "#{$project[:systree][:config]}/#{$project[:cfgtree][:tmp]}/#{e[0]}.erb"
              break
            end
          end
          if tmpfile == [] then
            puts "error: unable to find template for extension '*.#{ext}'."
            return
          end
          if File.extname(args[0]) == "" then
            outfiles << outname + '.' + ext
          else
          	outfiles << outname
          end
        end
      end
      tmpfile.each_with_index do |tfile, idx|
      	# Special when generate module.
      	if File.extname(args[0]) == "" or File.extname(args[0]) != File.extname(outfiles[idx]) then
      	  ARGV[0] = outfiles[idx]
      	end
        # Output verbose statistic.
        if global_options[:verbose].value != nil
          puts "outfile  : #{outfiles[idx]}"
          puts "template : #{tfile}"
        end
        # create output file.
        f = File.new( "#{@@context[:rundir]}/#{outfiles[idx]}", 'w' )
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

end # module Maker
