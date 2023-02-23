require 'rails_helper'

describe 'The Subscriptions API' do
  describe 'POST subscriptions' do
    before :each do
      @customer = create(:customer)
      @tea = create(:tea)
    end

    it 'can create a subscription for a given customer' do
      sub_params = {
                        title: 'Tea Taster',
                        price: 1500,
                        status: 'active',
                        frequency: 'weekly',
                        customer_id: @customer.id,
                        tea_id: @tea.id
                   }

      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'        
                }
                
      expect(Subscription.all.count).to eq(0)

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(sub_params)

      expect(Subscription.all.count).to eq(1)

      new_sub = Subscription.last
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful 
      expect(response.status).to eq(201)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:success)
      expect(response_data[:success]).to eq("Subscription added successfully!")
      
      expect(new_sub.title).to eq(sub_params[:title])
      expect(new_sub.price).to eq(sub_params[:price])
      expect(new_sub.status).to eq(sub_params[:status])
      expect(new_sub.frequency).to eq(sub_params[:frequency])
      expect(new_sub.customer_id).to eq(@customer.id)
      expect(new_sub.tea_id).to eq(@tea.id)
    end

    it 'returns an error if a required attribute is missing' do
      sub_params = {
                        title: 'Tea Taster',
                        price: 1500,
                        status: 'active',
                        customer_id: @customer.id,
                        tea_id: @tea.id
                   }

      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'        
                }

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(sub_params)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(Subscription.all.count).to eq(0)
      expect(response.status).to eq(400)
  
      expect(error_data).to have_key(:message)
      expect(error_data[:message]).to eq("Record is missing one or more attributes")
  
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq(["Frequency can't be blank"])
    end
  end
end