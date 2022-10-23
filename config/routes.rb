require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"


Rails.application.routes.draw do
  post 'book/create'
  get 'book/index'
  delete 'book/destroy', to: 'book#destroy'
  put 'book/update', to: 'book#update'
  post 'sign_up', to: 'authentication#sign_up'
  post 'login', to: 'authentication#login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope :monitoring do
    # Sidekiq Basic Auth from routes on production environment
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      [username, password] == [ENV["SIDEKIQ_AUTH_USERNAME"], ENV["SIDEKIQ_AUTH_PASSWORD"]]
    end if Rails.env.development?

    mount Sidekiq::Web, at: '/sidekiq'
  end
  
  
end
