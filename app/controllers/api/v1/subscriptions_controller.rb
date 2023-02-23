class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer

  def index
    render json: SubscriptionSerializer.new(@customer.subscriptions)
  end

  def create
    require 'pry'; binding.pry
  end

  private

    def find_customer
      @customer = Customer.find(params[:customer_id])
    end

    def subscription_params
      params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
    end
end