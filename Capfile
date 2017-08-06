# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require "capistrano/rbenv"
set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'

require 'capistrano/rails'

# Running whenever in capistrano deployments (cron jobs)
set :whenever_command, 'bundle exec whenever'
require 'whenever/capistrano'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
