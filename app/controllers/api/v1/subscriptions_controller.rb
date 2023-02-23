class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer
  
  def index
    require 'pry'; binding.pry
  end

  private

    def find_customer
      @customer = Customer.find(params[:customer_id])
    end
end