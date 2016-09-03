$tmp_readme = %q{
# <%= ARGV[0] %>
TODO: describe about your project here...

### Project Tree
* [<%= Maker::PROFILE[:systree][:app] %>]       -- project target applications.
* [<%= Maker::PROFILE[:systree][:config] %>]    -- directory with configuration files and templates.
* [<%= Maker::PROFILE[:systree][:doc] %>]       -- directory with documentation on project.
* [<%= Maker::PROFILE[:systree][:lib] %>]       -- library applications.
* [<%= Maker::PROFILE[:systree][:test] %>]      -- contain complex and finally tests for project.
* [<%= Maker::PROFILE[:systree][:tools] %>]     -- utilites and tools for project.
* [<%= Maker::PROFILE[:systree][:vendor] %>]    -- third-party source code and executables.
* profile.rb  -- project structuries file in Ruby language.
* <%= Maker::PROFILE[:systree][:license] %> -- file with licese information.
* <%= Maker::PROFILE[:systree][:readme] %>   -- Readme file in markdown style.

# Deploy project environment
TODO: how install tools (applications) needed for your project...

# Build project
TODO: how build project...

# Testing project
TODO: how testing project...

# Install
TODO: how install or programm (deploy your product)...
}
