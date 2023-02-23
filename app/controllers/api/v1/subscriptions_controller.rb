class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer

  def index
    render json: SubscriptionSerializer.new(@customer.subscriptions)
  end

  def create
    subscription = Subscription.new(sub_params)
    subscription.save
    render json: { success: "Subscription added successfully!" }, status: :created
  end

  private

    def find_customer
      @customer = Customer.find(params[:customer_id])
    end

    def sub_params
      params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
    end
end