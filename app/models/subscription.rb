class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :status, :frequency, presence: true
  validates_numericality_of :price
end
