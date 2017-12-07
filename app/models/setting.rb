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

  def self.display_price
    # change this to the desired display price
    
    p1v = self.price_range_1_value
    p2v = self.price_range_2_value
    p3v = self.price_range_3_value
    p4v = self.price_range_4_value

    return (p1v.to_f + p2v.to_f + p3v.to_f + p4v.to_f)/4
  end

  def self.prices
    p1 = self.price_range_1.to_f
    p2 = self.price_range_2.to_f
    p3 = self.price_range_3.to_f
    p4 = self.price_range_4.to_f

    p1v = self.price_range_1_value.to_f
    p2v = self.price_range_2_value.to_f
    p3v = self.price_range_3_value.to_f
    p4v = self.price_range_4_value.to_f
    
    return [
      {
        min: p1,
        minb: p1 / p1v,
        price: p1v
      },
      {
        min: p2,
        minb: p2 / p2v,
        price: p2v
      },
      {
        min: p3,
        minb: p3 / p3v,
        price: p3v
      },
      {
        min: p4,
        minb: p4 / p4v,
        price: p4v
      }
    ]
  end

end
