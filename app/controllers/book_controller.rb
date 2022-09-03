class BookController < ApplicationController

  def index
    render json: Book.all.select(:name_book, :pages)
  end
  
  def create
    if Rails.env.development?
      Workers::CreateBookWorker.perform_async(params[:name_book], params[:pages])
    elsif Rails.env.production?
      Business::CreateBook.new.call(name_book: params[:name_book], pages: params[:pages])
    end
    
    render json: { status: 'User created' }
  end

  def update
    Business::UpdateBook.new.call(id_book: params[:id], name_book: params[:name_book], pages: params[:pages])
    render json: { status: 'Book Updated' }
  end

  def destroy
    Business::DeleteBook.new.call(id_book: params[:id])
    render json: { status: 'Book deleted' }
  end

  private

  def set_params
    params.permit(:name_book, :pages)
  end
end
