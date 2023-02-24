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
        expect(subscription[:attributes]).to have_key(:tea_id)
        
        expect(subscription[:attributes]).to have_key(:customer_id)
        expect(subscription[:attributes][:customer_id]).to eq(@customer1.id)
        
        expect(subscription[:attributes].keys.size).to eq(6)
      end
    end

    it 'returns an error when an invalid customer id is used to get all subscriptions' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'        
                }
      
      get "/api/v1/customers/1234567890/subscriptions", headers: headers

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:message)
      expect(error_data[:message]).to eq('No record found')
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq("Couldn't find Customer with 'id'=1234567890")
    end

    it 'returns an empty array if the customer has no subscriptions' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'        
                }
      
      get "/api/v1/customers/#{@customer3.id}/subscriptions", headers: headers

      no_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful 
      expect(response.status).to eq(200)

      expect(no_data).to be_a(Hash)
      expect(no_data).to have_key(:data)
      expect(no_data[:data]).to eq([])
    end
  end
end