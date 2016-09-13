class Event < ApplicationRecord
  validates_presence_of :name , :description

  has_many :attendees
  has_many :participate_users , :through => :attendees , :source => :user
  belongs_to :user
end
