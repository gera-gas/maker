require 'maker'

# Global configuration file.
$tmp_global_config = [
"# Global configuration script.",
"# Write you setting for each OS types.",
"require 'os'",
"",
"# Settings for Windows family OS.",
"if OS.windows? then",
"  case OS.bits",
"  when 32",
"    # TODO: only for 32 bitness.",
"  when 64",
"    # TODO: only for 64 bitness.",
"  end",
"end",
"",
"# Settings for Linux family OS.",
"if OS.linux? then",
"  case OS.bits",
"  when 32",
"    # TODO: only for 32 bitness.",
"  when 64",
"    # TODO: only for 64 bitness.",
"  end",
"end",
"",
"# Settings for MAC family OS.",
"if OS.mac? then",
"  case OS.bits",
"  when 32",
"    # TODO: only for 32 bitness.",
"  when 64",
"    # TODO: only for 64 bitness.",
"  end",
"end",
"",
"# Global config variables.",
"$global_config = {",
"  # Templates setting for 'gen' command.",
"  :gen => {",
"    :src => ['c', 'cc', 'cpp', 'c++', 'cxx'],",
"    :hdr => ['h', 'hpp', 'hxx'],",
"    :main => [],",
"    :main_hello => [],",
"  },",
"  # Set additional environment settings.",
"  # May be change by option '-e=[...]' of some commands.",
"  :env => 'develop',",
"}"
]
