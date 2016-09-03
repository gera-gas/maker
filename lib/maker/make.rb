require 'find'

module Maker

  class App < Hash
    include Maker

    def initialize ( app_name = Dir.pwd.split('/').last )
      raise TypeError, 'Application name is not <String> type.' unless app_name.instance_of? String

      self[:appname]  = app_name
      self[:active]   = true
      self[:brief]    = []
      self[:ldscript] = ''
      self[:cpplist]  = []
      self[:srcdir]   = ['src',]
      self[:hdrdir]   = ['include',]
      self[:outdir]   = 'bin'
      self[:outtype]  = 'elf'
      self[:option]   = {
        :ar  => [], # options for archive utilites, $(cc)-ar
        :ld  => [], # linker options, $(cc)-ld (-nostdlib, -T, ...)
        :dbg => [], # [asm, c, c++] - debug options (-g, -save-temps, ... )
        :opt => [], # [ - , c, c++] - optimization options (-O2, -Os, ...)
        :cpu => [], # [ - , c, c++] - target options (-mcpu, ...)
        :msg => [], # [ - , c, c++] - message options.
        :cpp => [], # [asm, c, c++] - preprocessor options for all language (-D, ... )
                    # [asm, -,  - ] - for assembler language options
        :asm => {
          :cpp => [], # preprocessor options for assembler.
          :gcc => [], # compiller options for assembler.
        },
                    # [ - , c,  - ] - for C language options
        :c => {
          :cpp => [], # preprocessor options for C.
          :gcc => [], # compiller options for C.
        },
                    # [ - , -, c++] - for C++ language options
        :cxx => {
          :cpp => [], # preprocessor options for C++.
          :gcc => [], # compiller options for C++.
        },
      }
      self[:kick] = {
        :file => [],
        :dir  => [],
      }
      self[:lib] = {
        :path  => [],
        :name  => [],
        :group => [],
      }

      @option = {
        :inc => '',
      }
      
      @ignore   = '!'
      @makelist = []

      @out = {
        :bin => '',
        :dep => '',
        :cpp => '',
        :obj => '',
        :log => '',
      }
      @extlist = {
        :asm => [ '.S', '.asm' ],
        :c   => [ '.c' ],
        :cpp => [ '.cpp', '.c++', '.cxx' ],
        :pre => [ '.erb' ],
      }
      @apptree = {
        :src => [],
        :hdr => [],
      }
    end


    # Private methods for internal using.
    def logtitle ( title )
      f = File.new( @out[:log], 'a' )
      f.puts "_" * 80
      f.puts 
      f.puts "<< " + title.upcase + " >>"
      f.puts "_" * 80
      f.puts 
      f.close
    end

    def logout ( line )
      f = File.open( @out[:log], 'a' )
      f.puts line
      f.close
    end

    def loginfo ( title, listinfo )
      if listinfo.size > 0 then
        logtitle( title )
        listinfo.each do |f|
          logout f
        end
      end
    end

    def getopt ( optlist )
      optline = ''
      optlist.each do |opt|
        optline += opt + ' '
      end
      optline
    end
    
    def getdeps( f )
      deps = ''
      File.open( f, 'r' ).each do |line|
        l = line.strip
        l[l.length-1] = ' ' if l[l.length-1] == '\\'
        deps += l
      end
      return deps
    end
    
    private :logtitle, :logout, :getopt, :getdeps, :loginfo


    # Create copy of self object.
    def copy
       Marshal.load( Marshal.dump(self) )
    end


    # Configure application.
    def config ( buildname )
      Maker.error( "Nothis to build." ) if self[:srcdir].empty?

      splitdir = ''
      splitdir = '/' if !buildname.empty?

      @out[:bin] = self[:outdir] + '/' + buildname + splitdir
      @out[:dep] = @out[:bin] + 'dep'
      @out[:cpp] = @out[:bin] + 'cpp'
      @out[:obj] = @out[:bin] + 'obj'
      @out[:log] = @out[:bin] + self[:appname] + '.log'
      @out[:inf] = @out[:bin] + self[:appname] + '.inf'

      Dir.mkdir( self[:outdir] ) if !Dir.exist?( self[:outdir] )

      Dir.mkdir( @out[:bin] ) if !Dir.exist?( @out[:bin] )
      Dir.mkdir( @out[:dep] ) if !Dir.exist?( @out[:dep] )
      Dir.mkdir( @out[:cpp] ) if !Dir.exist?( @out[:cpp] )
      Dir.mkdir( @out[:obj] ) if !Dir.exist?( @out[:obj] )

      f = File.new( @out[:log], 'w' )
      f.close

      logtitle( 'path' )

      ENV['PATH'].split(Maker::Env.delimitter).each do |v|
        logout( v )
      end

      self[:cpplist] << self[:ldscript] if self[:ldscript].length > 0

      self[:srcdir].each do |dir|
        Find.find(dir) do |e|
          if FileTest.directory?(e)
            @apptree[:src] << e if !self[:kick][:dir].include?(e)
          end
        end
      end
      self[:hdrdir].each do |dir|
        Find.find(dir) do |e|
          if FileTest.directory?(e)
            @apptree[:hdr] << e
          end
        end
      end
    end


    # Make precompute.
    def precompute
      prelist = []
      # Create list with precompute files
      # and handling them.
      @apptree[:src].each do |srcdir|
        # Create file mask's to files found.
        masklist = []
        @extlist[:pre].each do |e|
          masklist << srcdir + '/*' + e
        end
        FileList.new( masklist ).each do |f|
          filein  = f
          fileout = f.ext('')
          if Maker.needupdate?( fileout, [filein,] ) then
            prelist << "erb #{filein} > #{fileout}"
          else
            prelist << "erb #{filein} > #{fileout}" if File.size( fileout ) == 0
          end
        end
      end
      # Create list with precompute files
      # and handling them.
      @apptree[:hdr].each do |hdrdir|
        # Create file mask's to files found.
        masklist = []
        @extlist[:pre].each do |e|
          masklist << hdrdir + '/*' + e
        end
        FileList.new( masklist ).each do |f|
          filein  = f
          fileout = f.ext('')
          if Maker.needupdate?( fileout, [filein,] ) then
            prelist << "erb #{filein} > #{fileout}"
          else
            prelist << "erb #{filein} > #{fileout}" if File.size( fileout ) == 0
          end
        end
      end
      # Create log.
      loginfo( 'precompute', prelist )
      return prelist
    end


    # Create dependences.
    def dependence
      cpplist = []

      logtitle( 'includes' )
      @apptree[:hdr].each do |h|
        @option[:inc] += '-I' + h + ' '
        logout h
      end
      optline = @option[:inc] + getopt( self[:option][:cpp] )

      logtitle( 'sources' )

      handledfiles = { :n =>[], :f =>[] }

      @apptree[:src].each do |src|
        # Create file mask's to files found.
        masklist = []
        @extlist[:asm].each do |e|
          masklist << src + '/*' + e
        end
        @extlist[:c].each do |e|
          masklist << src + '/*' + e
        end
        @extlist[:cpp].each do |e|
          masklist << src + '/*' + e
        end
        FileList.new( masklist ).each do |f|
          #
          # Проверка имени файла на совпадение с именами других,
          # уже обработанных файлов, т.к. сборка всех файлов
          # выполняется в одну директорию, то возможно
          # перетирание файла.
          #
          handledfiles[:n].each_with_index do |v,i|
            if v == File.basename( f.ext('') ) then
              Maker.error( 'Conflict filename: ' + handledfiles[:f][i] + ', ' + f )
            end
          end
          #
          # Анализ условий для отсеивания файлов.
          # 1 - если это не файл.
          # 2 - если в начале имени файла есть признак @ignore.
          # 3 - задано условие в :kick.
          #
          next if File.file?(f) == false
          next if File.basename(f)[0] == @ignore
          next if self[:kick][:file].include?( File.basename(f) )
          #
          # Файл будет собираться в данном проекте,
          # необходима обработка.
          #
          if( @extlist[:cpp].include?(File.extname(f)) )
            gcc = 'g++ -E -M ' + getopt( self[:option][:cxx][:cpp] )
          else
            gcc = 'cpp -M ' + getopt( self[:option][:c][:cpp] )
          end
          cpplist << "#{$project[:gcc][:cc]}#{gcc} #{optline} #{f} > #{@out[:dep]}/#{File.basename(f.ext('d'))}"
          #
          # Постобработка:
          # добавляем файл в список для сборки, пишем в лог
          # и добавляем в список уже обработанных файлов.
          #
          @makelist << f
          logout( f )
          # Фиксация (накопление) для проверки повторного входа файла.
          handledfiles[:n] << File.basename(f.ext(''))
          handledfiles[:f] << f
        end
      end
      return cpplist
    end


    # Processing linker script file and
    # any files from :cpplist.
    def preprocessor
      cpplist = []

      self[:cpplist].each do |f|
        # Препроцессорнaя обработка выполняется безусловно, т.е.
        # без формирования зависимостей, т.к. зависимости формируются
        # препроцессором, то не имеет смысла "гонять" его дважды.
        if( @extlist[:cpp].include?(File.extname(f)) )
          gcc = 'g++ ' + getopt( self[:option][:cxx][:cpp] )
        else
          gcc = 'cpp ' + getopt( self[:option][:c][:cpp] )
        end
        cpplist << "#{$project[:gcc][:cc]}#{gcc} -P #{@option[:inc]} #{getopt( self[:option][:cpp] )} #{f} > #{@out[:cpp]}/#{File.basename(f)}"
      end
      loginfo( 'preprocessor', cpplist )
      return cpplist
    end


    # Compile source files.
    def compiling
      cclist = []
      @makelist.each do |f|
        depfile = File.basename( f.ext('d') )
        deps = getdeps( "#{@out[:dep]}/#{depfile}" ).split(': ')
        next if !Maker.needupdate?( "#{@out[:obj]}/#{deps[0]}", deps[1].split(' ') )
        # file need recompile.
        gcc = ''
        opt = @option[:inc] + getopt( self[:option][:cpp] ) + getopt( self[:option][:dbg] )
        if( @extlist[:asm].include?(File.extname(f)) )
          gcc = 'gcc'
          opt += getopt( self[:option][:asm][:gcc] )
        elsif( @extlist[:c].include?(File.extname(f)) )
          gcc = 'gcc'
          opt += getopt( self[:option][:c][:cpp] )
          opt += getopt( self[:option][:opt] )
          opt += getopt( self[:option][:msg] )
          opt += getopt( self[:option][:c][:gcc] )
          opt += getopt( self[:option][:cpu] )
        elsif( @extlist[:cpp].include?(File.extname(f)) )
          gcc = 'g++'
          opt += getopt( self[:option][:cxx][:cpp] )
          opt += getopt( self[:option][:opt] )
          opt += getopt( self[:option][:msg] )
          opt += getopt( self[:option][:c][:gcc] )
          opt += getopt( self[:option][:cpu] )
        else
          Maker.error( 'Unknown file type - ' + f )
        end
        cclist << "#{$project[:gcc][:cc]}#{gcc} #{opt} -o #{@out[:obj]}/#{deps[0]} -c #{f}"
      end
      loginfo( 'compile', cclist )
      return cclist
    end


    # Make application (linking object files).
    def linking
      linkcmd = ''
      objlist = ''

      # unroll objects list to string.
      FileList.new( @out[:obj] + '/*.o' ).each do |o|
        objlist += " #{o}"
      end
      
      case self[:outtype]
      # Raw linking (link use "ld" utilites).
      when 'ld'
      # Executable format of output file.
      when 'elf'
        linkcmd = 'g++ '
        self[:lib][:path].each do |p|
          if !p.empty? then
            if p.length > '-L'.length then
              p = "-L#{p}" if p[0,'-L'.length] != '-L'
            end
            linkcmd += "#{p} "
          end
        end
      # Static Library format of output file.
      when 'a'
        aropt = getopt( self[:option][:ar] )
        aropt = 'rcs' if aropt.empty?
        linkcmd = "#{$project[:gcc][:cc]}ar #{aropt} #{@out[:bin]}lib#{self[:appname]}.a #{objlist}"
      # Shared Library format of output file.
      when 'so'
      else
        Maker.error( 'Unknown format <' + self[:outtype] + '> to output file.' )
      end
      return linkcmd
    end

  end # class App

end # module Maker
