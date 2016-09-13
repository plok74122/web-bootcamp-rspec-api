class Event < ApplicationRecord
  has_many :attendees
  has_many :participate_users , :through => :attendees
  belongs_to :user
end
