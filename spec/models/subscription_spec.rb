require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end

  describe 'Validations' do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :tea_id }
    it { should validate_numericality_of :price}
  end
end
