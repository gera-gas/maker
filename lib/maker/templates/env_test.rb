$env_test = [
"# Configuration script for testing environments.",
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
]
