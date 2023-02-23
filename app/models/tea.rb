class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates_presence_of :title, :description, :temperature, :brew_time
  validates :temperature, :brew_time, numericality: true
end
