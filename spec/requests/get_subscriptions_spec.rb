require 'rails_helper'

describe 'The Subscriptions API' do
  describe 'GET subscriptions' do
    before :each do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)

      @tea1 = create(:tea)
      @tea2 = create(:tea)
      @tea3 = create(:tea)

      create_list(:subscription, 2, customer: @customer1, tea: @tea1)
      create(:subscription, customer: @customer1, tea: @tea2, status: "cancelled")
      create(:subscription, customer: @customer2, tea: @tea3)
    end

    it 'can get all subscriptions for a given customer' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'        
                }
      get "/api/v1/customers/#{@customer1.id}/subscriptions", headers: headers

      expect(response).to be_successful 
      subscriptions = JSON.parse(response.body,symbolize_names: true)

      expect(subscriptions).to be_a(Hash)
      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).to be_an(Array)
      expect(subscriptions[:data].size).to eq(3)

      subscriptions[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")

        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes]).to have_key(:created_at)
        expect(subscription[:attributes]).to have_key(:updated_at)
        expect(subscription[:attributes]).to have_key(:tea_id)
        
        expect(subscription[:attributes]).to have_key(:customer_id)
        expect(subscription[:attributes][:customer_id]).to eq(@customer1.id)
        
        expect(subscription[:attributes].keys.size).to eq(8)
      end
    end
  end
end