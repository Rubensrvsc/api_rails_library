# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  before_action :authenticate_request
  before_action :current_ability

  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find_by(id: decoded[:id])
  rescue StandardError
    render json: { error: 'Invalid credentials' }
  end
end
