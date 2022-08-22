# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find_by(id: decoded[:user_id])
  rescue StandardError
    render json: { error: 'Invalid credentials' }
  end
end
