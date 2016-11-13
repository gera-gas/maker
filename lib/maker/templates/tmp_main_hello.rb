# Global configuration file.
$tmp_main = [
'/**',
' *  @file  <%= ARGV[0] %>',
' *  @date  <%= Time.now %>',
' *  @brief Entry point to program.',
' */',
'#include <stdio.h>',
'',
'int main ( int argc, char* argv[] )',
'{',
'    printf("Hello World!\n");',
'    return 0;',
'}'
]
