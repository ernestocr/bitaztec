Rails.application.routes.draw do

  devise_for :users
  
  resources :orders, except: :new
  match '/comprar', to: 'orders#new', as: :new_order, via: :get

  resources :messages, only: [:create]

  namespace :admin do
    match '/', to: 'dashboard#index', via: :get
    resources :users
    resources :payment_methods
    resources :settings
    resources :orders
  end
  
  root to: 'pages#home'

  get '/instrucciones', to: 'pages#howto', as: :howto
  get '/legal', to: 'pages#legal', as: :legal
  get '/preguntas', to: 'pages#faq', as: :faq
  get '/contacto', to: 'pages#contact', as: :contact

end
