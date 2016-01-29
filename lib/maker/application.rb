module Maker

  class Application
    include Maker

    def initialize
      @handler = Cmdlib::Handler.new
      @handler.usage << 'Maker utilites. Copyright (C) 2015 Anton S. Gerasimov.'
      @handler.usage << 'License MIT, email: gera_box@mail.ru.'
      @handler.usage << 'Full-stack framework for develop embedded software.'
      @handler.usage << ''
      @handler.usage << '  Usage: maker <command> [OPTIONS...]'

      @pro = CLIproject.new
      @pro.describe.oname = 'new'
      @pro.describe.brief = 'Create new \'maker\' project.'
      @pro.describe.details << 'This command generate base project structure.'
      @pro.describe.example << 'Create project: maker new <your-project-name>'
      @pro.argnum = 1
      
      @app = CLIapp.new
      @app.describe.oname = 'app'
      @app.describe.brief = 'Create application structure skelet.'
      @app.describe.details << 'This command generate base application structure.'
      @app.describe.details << 'You can create standalone application, by generate with -a or --alone.'
      @app.describe.example << 'Create project application: maker app <you-application-name>'
      @app.argnum = 1

      @gen = CLIgen.new
      @gen.describe.oname = 'gen'
      @gen.describe.brief = 'Create application sources.'
      @gen.describe.details << 'This command generate sources with initial content.'
      @gen.describe.details << 'You can create templates to you sources.'
      @gen.describe.example << 'Generate header file: maker gen <you-file-name>.h'
      @gen.argnum = 1

      @cmd = CLIcmd.new
      @cmd.describe.oname = 'cmd'
      @cmd.describe.brief = 'Execute OS command in project environment.'
      @cmd.describe.details << 'For command execute run maker and wait prompt,'
      @cmd.describe.details << 'after prompt, you will can OS command.'
      @cmd.describe.example << 'Run maker     : maker cmd -v'
      @cmd.describe.example << 'Input command : ls'
      @cmd.describe.example << ''
      @cmd.describe.example << 'Also you can run: maker "cmd" in shell mode: maker cmd -s'

      @handler.addcmd @pro
      @handler.addcmd @app
      @handler.addcmd @gen
      @handler.addcmd @cmd

      # create options.
      @@options[:version]  = Cmdlib::Option.new( 'V', 'version', 'Option display program version.' )
      @@options[:verbose]  = Cmdlib::Option.new( 'v', 'verbose', 'Option enable verbose mode.' )
      @@options[:loopmode] = Cmdlib::Option.new( 'l', 'loopmode', 'Option enable loop mode for: Maker cmd.' )

      @handler.addopt @@options[:version]
      @handler.addopt @@options[:verbose]
      @handler.addopt @@options[:loopmode]
    end

    def run
      @handler.run
      if @@options[:version].value != nil then
        puts "Maker, version #{Maker::VERSION}"
        exit
      end
      puts 'Maker: too few arguments, run program with helpful options, example: maker help'
    end
  end

end # module Maker
