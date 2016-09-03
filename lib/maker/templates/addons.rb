$tmp_addons = %q{
module Maker
  # Project specify command.
  # For more details to write this code, see RubyGem <cmdlib>.
  class <%= ARGV[1] %> < Cmdlib::Command
    include Maker
    def init
      @name = '<%= ARGV[0] %>'
      @brief = 'TODO: ...'
      @details << 'TODO: ...'
      @example << 'maker <%= ARGV[0] %>'
      @argnum = 0
    end
    
    def handler( global_options, args )
      puts 'TODO: put here command handler code...'
    end
  end
end
}
