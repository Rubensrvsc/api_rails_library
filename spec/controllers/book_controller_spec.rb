# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe BookController, type: :controller do
  before(:each) do
    @user = User.create!(
        name: Faker::Name.name,
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'wxcvbn'
      )
    @book = create(:book)
    @token = JWT.encode({ id: @user.id }, Rails.application.secret_key_base)
  end
  context 'methods of #bookcontroller' do
    it 'get all books' do
      request.headers["Authorization"] = @token
      get :index
      expect(Book.count).to eq(1)
    end
    it 'size jobs for create user' do
      request.headers["Authorization"] = @token
      post :create, params: { name_book: 'Teste', pages: 150 }
      expect(Workers::CreateBookWorker.jobs.size).to eq(1)
    end

    it 'destroy book' do
      request.headers["Authorization"] = @token
      delete :destroy, params: { id: @book.id }
      expect(Book.count).to eq(0)
    end

    it 'update book' do
      request.headers["Authorization"] = @token
      put :update, params: { id: @book.id, name_book: 'Teste', pages: 150 }
      expect(Book.find_by(id: @book.id).name_book).to eq('Teste')
    end
  end
end
