class BookController < ApplicationController
  skip_before_action :authenticate_request, only: %i[find_book]
  load_and_authorize_resource

  def index
    render json: Book.all.select(:name_book, :pages)
  end
  
  def create
    if Rails.env.development? || Rails.env.test?
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

  def find_book
    book = Business::Domain.new.find_by_id(id_book: params[:id_book])
    
    if book.present?
      render json: { book: book, status: :ok }
    else
      render json: { status: 'Not find book' }
    end
  end

  private

  def set_params
    params.permit(:name_book, :pages)
  end
end
