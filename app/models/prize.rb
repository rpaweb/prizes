class Prize < ActiveRecord::Base
  belongs_to :rule
  has_many :winners

  mount_uploader :photo, PrizeUploader

  validates :name, :desc, :amount, :photo, presence: true
  validates_format_of :photo, with: %r{\.(png|jpg|jpeg)$}i, multiline: true, message: "invalid format"
  validates_numericality_of :amount
end
