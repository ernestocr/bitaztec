set :stage, :production
server '45.55.148.230', user: 'deploy', roles: %w(app db web)
