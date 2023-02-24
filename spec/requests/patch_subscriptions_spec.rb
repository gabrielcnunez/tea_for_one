require 'rails_helper'

describe 'The Subscriptions API' do
  describe 'PATCH subscriptions' do
    before :each do
      @customer = create(:customer)
      @tea = create(:tea)
      @subscription = create(:subscription, customer: @customer, tea: @tea)
    end

    it 'can cancel a subscription by updating the status attribute' do
      patch_params = {
                        title: @subscription.title,
                        price: @subscription.price,
                        status: 'cancelled',
                        frequency: @subscription.frequency,
                        customer_id: @subscription.customer_id,
                        tea_id: @subscription.tea_id
                   }

      headers = {
                     'Content-Type' => 'application/json',
                     'Accept' => 'application/json'        
                }

      patch "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(patch_params)

      expect(Subscription.all.count).to eq(1)

      expect(response).to be_successful 
      expect(response.status).to eq(200)

      cancelled_sub = Subscription.find(@subscription.id)

      expect(cancelled_sub.title).to eq(@subscription.title)
      expect(cancelled_sub.price).to eq(@subscription.price)
      expect(cancelled_sub.status).to eq('cancelled')
      expect(cancelled_sub.frequency).to eq(@subscription.frequency)      
      expect(cancelled_sub.customer_id).to eq(@subscription.customer_id)      
      expect(cancelled_sub.tea_id).to eq(@subscription.tea_id)      
    end
  end
end