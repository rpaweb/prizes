class Subscriber < ActiveRecord::Base
  has_one :winner

  validates :email, presence: true
  validate :daily_email_uniqueness, on: :create

  def daily_email_uniqueness
    email_record = Subscriber.where(email: self.email).where(created_at: Time.current.all_day)
    errors.add(:email, 'cannot be used again today. Try tomorrow') unless email_record.empty?
  end
end
