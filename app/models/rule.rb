class Rule < ActiveRecord::Base
  has_many :prizes, dependent: :destroy

  validates :policy, presence: true
end
