set :output, "log/cron_log.log"

env :PATH, ENV["PATH"]
env :GEM_PATH, ENV["GEM_PATH"]

#set :environment, "development"

#job_type :rbenv_rake, %Q{export PATH=/Users/ernesto/.rbenv/shims:/Users/ernesto/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; cd :path && :environment_variable=:environment bundle exec rake :task :output }

every 30.minutes do
  rake "orders:notify_expiration"
end

every 10.minutes do
  rake "price:update"
end
