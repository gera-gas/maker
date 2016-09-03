require "erb"

module Maker

  # Create addons.
  class Addon < Cmdlib::Command
    include Maker
    def init
      @name = 'addon'
      @brief = 'Create an additional command for this project.'
      @details << 'Generate template with special structure.'
      @details << 'Fill method <init> and method <handler> your code implementation command.'
      @details << 'This command visible and may be used inside of this project only.'
      @details << ''
      @details << 'maker addon [COMMAND-NAME]'
      @example << ''
      @example << '$ ls -a'
      @example << '. ..'
      @example << ''
      @example << '$ maker new demo -s'
      @example << 'generate project : demo ...'
      @example << ''
      @example << '$ ls -a'
      @example << '. .. demo'
      @example << ''
      @example << '$ cd demo/config/addons'
      @example << '$ ls -a'
      @example << '. ..'
      @example << ''
      @example << '$ maker addon deploy'
      @example << '$ ls -a'
      @example << '. .. deploy.rb'
      @argnum = 1
    end
    
    def handler( global_options, args )
      # check result of project searching.
      if @@context[:project] == '' then
	puts 'error: unable to execute this command outside of project.'
	return
      end
      # check named rules.
      unless args[0] =~ /^[a-z]+$/ then
	puts 'error: command name can contain only lowercase letters (a-z).'
	return
      end
      ARGV[1] = Maker.toclass( args[0] )
      # generate template for user command.
      require 'maker/templates/addons.rb'
      f = File.new( "#{$project[:systree][:config]}/#{$project[:cfgtree][:add]}/#{args[0]}.rb", 'w' )
      erbout = ERB.new( $tmp_addons, 0, "%<>" )
      f.puts erbout.result
      f.close
    end

  end

end # module Maker
