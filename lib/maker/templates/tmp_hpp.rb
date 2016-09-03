$tmp_hpp = [
'<% headername = ARGV[1].upcase.gsub(?.,?_) %>',
'#ifndef <%= headername %>',
'#define <%= headername %>',
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
