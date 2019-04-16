module Maker

  # Transform string to class name.
  def self.toclass ( str )
    return str if str.length == 0
    return str.upcase if str.length == 1
    return str[0].upcase + str[1,str.length]
  end
  
  # Create directory with preliminary check on exist.
  def self.makedir ( dir )
    raise TypeError, 'Incorrectly types for directory name.' unless
      dir.instance_of? String
      
   curdir = Dir.pwd
   dir.split("/").each do |e|
      if !Dir.exist?( e ) then
        Dir.mkdir( e )
      end
      Dir.chdir( e )
    end
    Dir.chdir( curdir )
  end
  
  # Find project directory (find project.rb file)
  # and return true to project,else return false.
  def self.findproject
    @@context[:rundir] = Dir.pwd
    @@context[:curdir] = Dir.pwd
    path_to_profile = "./#{@@context[:profile]}"
    # already run in project directory.
    if File.exist? @@context[:profile] then
      require path_to_profile
      require "./#{$project[:systree][:config]}/#{$project[:cfgtree][:cfg]}"
      return true
    end
    # back step in directory tree.
    (Dir.pwd.split('/').size - 1).times do
      Dir.chdir '../'
      if File.exist? @@context[:profile] then
        @@context[:curdir] = Dir.pwd
        require path_to_profile
        require "./#{$project[:systree][:config]}/#{$project[:cfgtree][:cfg]}"
        return true
      end
    end
    return false
  end

  # Ruby examples method for find files.
  def self.findfiles ( dir, name )
    list = []
    require 'find'
    Find.find(dir) do |path|
      Find.prune if [".",".."].include? path
      case name
        when String
          list << path if File.basename(path) == name
        when Regexp
          list << path if File.basename(path) =~ name
      else
        raise ArgumentError
      end
    end
    return list
  end

  # Configure sources method.
  def self.configure
    cfgin_dir  = "#{$project[:systree][:config]}/#{$project[:cfgtree][:in]}"
    cfgout_dir = "#{$project[:systree][:common]}/generated"
    # Find all files with *.in extension.
    filelist = Maker.findfiles(cfgin_dir, /\.in$/)
    Maker.makedir(cfgout_dir)
    # Generate sources from configure files.
    filelist.each do |cfgfile|
      outfile = File.basename(cfgfile, '.in')
      cmdline = "#{cfgfile} -o #{cfgout_dir}/#{outfile}"
      $global_config[:in][File.basename(cfgfile.split('.')[0]).to_sym].each do |key, val|
        cmdline += " #{key}=#{val}"
      end
      puts "generate - #{cfgfile} ..."
      `ccfg #{cmdline}`
    end
  end
  
end # module Maker
