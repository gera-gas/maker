$tmp_hpp = [
'<% headername = ARGV[0].upcase.gsub(?.,?_) %>',
'#ifndef <%= headername %>',
'#define <%= headername %>',
'/**',
' *  @file  <%= ARGV[0] %>',
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
