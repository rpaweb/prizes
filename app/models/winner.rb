class Winner < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :prize
end
