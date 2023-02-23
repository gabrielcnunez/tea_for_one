class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(exception)
    render json: ErrorSerializer.not_found(exception.message), status: :bad_request
  end
end
