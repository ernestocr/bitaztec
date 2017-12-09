set :stage, :staging
server '174.138.48.78', user: 'deploy', roles: %w(app db web)
set :rails_env, :staging
