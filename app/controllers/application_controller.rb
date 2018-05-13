class ApplicationController < ActionController::Base
  protect_from_forgery
  # Called when there is an exception
  rescue_from StandardError, with: :render_error_response

  # Render HTTP status 422 with error details
  def render_error_response(exception)
    render json: { error: exception.message }, status: 422
  end
end
