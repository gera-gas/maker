# Templates for generation commands.
require 'maker'

# Profile.
$tmp_profile = %q{
# This is project struct file.
# You can prcessing carefully modify this fields,
# but do not rename map variables.
# 
# <%= Time.now.to_s %>
$project = {
  :name => '<%= ARGV[1] %>',
  # project directory tree struct.
  :systree => {
    :app     => '<%= Maker::PROFILE[:systree][:app] %>',
    :config  => '<%= Maker::PROFILE[:systree][:config] %>',
    :doc     => '<%= Maker::PROFILE[:systree][:doc] %>',
    :lib     => '<%= Maker::PROFILE[:systree][:lib] %>',
    :test    => '<%= Maker::PROFILE[:systree][:test] %>',
    :tools   => '<%= Maker::PROFILE[:systree][:tools] %>',
    :vendor  => '<%= Maker::PROFILE[:systree][:vendor] %>',
    :readme  => '<%= Maker::PROFILE[:systree][:readme] %>',
    :license => '<%= Maker::PROFILE[:systree][:license] %>',
  },
  # application directory tree struct.
  :apptree => {
    :doc      => '<%= Maker::PROFILE[:apptree][:doc] %>',
    :inc      => '<%= Maker::PROFILE[:systree][:app] %>',
    :script   => '<%= Maker::PROFILE[:apptree][:script] %>',
    :src      => '<%= Maker::PROFILE[:apptree][:src] %>',
    :makefile => '<%= Maker::PROFILE[:apptree][:makefile] %>',
  },
  # templates directory tree struct.
  :gentree => {
    :template => '<%= Maker::PROFILE[:gentree][:template] %>',
  },
  # config directory tree struct.
  :cfgtree => {
    :file => '<%= Maker::PROFILE[:cfgtree][:file] %>',
  },
  # config GNU GCC descriptors.
  :gcc => {
    :cc => '',
    :makelist => [],
  },
}
}


# License file.
$tmp_license = %q{
The MIT License (MIT)

Copyright (c) <%= Time.now.to_s[0,4] %> <%= ENV['USER'] %>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
}


# Global configuration file.
$tmp_global = [
'# Global configuration script.',
"require 'maker'",
'',
"# Write you setting for each OS types.",
"case Maker.ostype",
"when 'win32'",
"  # TODO: only for Windows family (32 bitness).",
"when 'win64'",
"  # TODO: only for Windows family (64 bitness).",
"when 'unix'",
"  # TODO: only for Unix family.",
"end",
"",
"# Global config variables.",
"$global = {",
"  # Templates setting for 'gen' command.",
"  :gen => {",
"    :src => ['.c', '.cc', '.cpp', '.c++', '.cxx'],",
"    :hdr => ['.h', '.hpp', '.hxx'],",
"  },",
"}"
]


# Local configuration file.
$tmp_local = [
'# Local configuration script for this application only.',
'# Configure your application here...',
"",
"# Write you setting for each OS types.",
"case Maker.ostype",
"when 'win32'",
"  # TODO: only for Windows family (32 bitness).",
"when 'win64'",
"  # TODO: only for Windows family (64 bitness).",
"when 'unix'",
"  # TODO: only for Unix family.",
"end"
]


# Global configuration file.
$tmp_main_c = [
'/**',
" *  @file  <%= ARGV[1] %>",
' *  @date  <%= Time.now %>',
' *  @brief Entry point to program.',
' */',
'#include <stdlib.h>',
'',
'int main ( int argc, char* argv[] )',
'{',
'    return 0;',
'}'
]

$tmp_cpp = [
'/**',
' *  @file  <%= ARGV[1] %>',
' *  @date  <%= Time.now %>',
' */'
]

$tmp_hpp = [
'<% headername = ARGV[1].upcase.gsub(?.,?_) %>',
"#ifndef <%= headername %>",
"#define <%= headername %>",
'/**',
' *  @file  <%= ARGV[1] %>',
' *  @date  <%= Time.now %>',
' */',
'#ifdef __cplusplus',
'extern "C" {',
'#endif',
'',
'#ifdef __cplusplus',
'}',
'#endif',
'',
'#endif /* <%= headername %> */'
]


# README file.
$tmp_readme = %q{
# <%= ARGV[1] %>
TODO: describe your project...

# Project Tree
* [<%= Maker::PROFILE[:systree][:app] %>]       -- project target applications.
* [<%= Maker::PROFILE[:systree][:config] %>]    -- directory with configuration files and templates.
* [<%= Maker::PROFILE[:systree][:doc] %>]       -- directory with documentation on source code.
* [<%= Maker::PROFILE[:systree][:lib] %>]       -- library applications.
* [<%= Maker::PROFILE[:systree][:test] %>]      -- contain complex and finally tests for project.
* [<%= Maker::PROFILE[:systree][:tools] %>]     -- utilites and tools for project.
* [<%= Maker::PROFILE[:systree][:vendor] %>]    -- third-party source code.
* project.rb  -- project structuries file in Ruby language.
* LICANSE.txt -- file with licese information.
* README.md   -- Readme file in markdown style.
}


# gitignore file.
$tmp_gitignore = [
"*.[oad]",
"*.elf",
"*.exe",
"*~",
"*.rc2",
"*.bmp",
"*.log",
"*.map",
"*.cbp",
"*.workspace",
"*.layout",
"*.ini",
"*.ico",
"*.bak"
]


# Rakefile.
$tmp_rakefile = %q{
require '../../profile.rb'
require '../../config/config.rb'
require './app.rb'
}
