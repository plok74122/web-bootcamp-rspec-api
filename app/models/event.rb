class Event < ApplicationRecord
  has_many :attendees
  has_many :participate_users , :through => :attendees , :source => :user
  belongs_to :user
end
