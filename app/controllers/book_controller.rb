class BookController < ApplicationController

  def index
    render json: Book.all.select(:name_book, :pages)
  end
  
  def create
    Workers::CreateBookWorker.perform_async(params[:name_book], params[:pages])
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
