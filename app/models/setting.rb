class Setting < ApplicationRecord

  default_scope { order(created_at: :desc) }

  validates :key, presence: true

  serialize :value

  def self.method_missing(method, *args)
    method = method.to_s
    result = self.where(key: method).first
    if result
      return result.value
    end

    return nil
  end

end
