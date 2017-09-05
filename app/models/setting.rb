class Setting < ApplicationRecord

  default_scope { order(created_at: :desc) }

  validates :key, presence: true

  serialize :value

  after_save :send_cron_later

  def self.method_missing(method, *args)
    method = method.to_s
    result = self.where(key: method).first
    if result
      return result.value
    end

    return nil
  end

  def send_cron_later
    delay.update_cron if key == 'interval'
  end

  def update_cron
    system 'bundle exec whenever --update-crontab'
  end

end
