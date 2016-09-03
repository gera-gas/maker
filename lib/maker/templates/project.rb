require 'maker'

$tmp_profile = %q{
# This is project struct file.
# You can carefully modifying this fields,
# but do not rename key name of hash.
# 
# <%= Time.now.to_s %>
$project = {
  :name => '<%= ARGV[0] %>',
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
    :inc      => '<%= Maker::PROFILE[:apptree][:inc] %>',
    :script   => '<%= Maker::PROFILE[:apptree][:script] %>',
    :src      => '<%= Maker::PROFILE[:apptree][:src] %>',
    :makefile => '<%= Maker::PROFILE[:apptree][:makefile] %>',
  },
  # templates directory tree struct.
  :cfgtree => {
    :add => '<%= Maker::PROFILE[:cfgtree][:add] %>',
    :tmp => '<%= Maker::PROFILE[:cfgtree][:tmp] %>',
    :env => '<%= Maker::PROFILE[:cfgtree][:env] %>',
    :cfg => '<%= Maker::PROFILE[:cfgtree][:cfg] %>',
  },
}
}
