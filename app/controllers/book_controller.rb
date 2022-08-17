class BookController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    render json: Book.all.select(:name_book, :pages)
  end
  
  def create
  end

  private

  def set_params
    params.permit(:name_book, :pages)
  end
end
