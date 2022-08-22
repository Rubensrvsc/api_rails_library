# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login sign_up]

  def login
    @user = User.find_by_username(params[:username])

    if @user&.authenticate(params[:password])
      token = jwt_encode({ id: @user.id })
      render json: { token: }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def sign_up
    user = User.create!(set_params_user)
    render json: {
      token: jwt_encode({ id: user.id }),
      user: 'User created'
    }
  end

  private

  def set_params_user
    params.permit(:name, :username, :email, :password)
  end
end
