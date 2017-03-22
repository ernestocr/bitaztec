Rails.application.routes.draw do

  devise_for :users
 
  # user buy route 
  resources :orders, except: :new
  match '/comprar', to: 'orders#new', as: :new_order, via: :get

  # message creation route
  resources :messages, only: [:create]

  # notifications
  resources :notifications do
    collection do
      post :mark_as_read
      get :count  
    end
  end

  # .../admin/...
  namespace :admin do
    match '/', to: 'dashboard#index', via: :get
    
    resources :users
    
    resources :payment_methods do
      collection do
        get 'toggle/:id' => :toggle, as: :toggle
      end
    end
    
    resources :settings
    resources :orders do
      collection do
        get 'history' => :history, as: :history
      end
    end

    resources :account_holders
    
    resources :banks do
      collection do
        get 'toggle/:id' => :toggle, as: :toggle
      end
      
      resources :accounts do
        collection do
          get 'toggle/:id' => :toggle, as: :toggle
        end
      end
    end
  end
  
  root to: 'pages#home'

  get '/instrucciones', to: 'pages#howto', as: :howto
  get '/legal', to: 'pages#legal', as: :legal
  get '/preguntas', to: 'pages#faq', as: :faq
  get '/contacto', to: 'pages#contact', as: :contact

end
