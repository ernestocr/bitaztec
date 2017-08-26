Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  # /comprar (for orders:new)
  resources :orders, except: :new
  match '/comprar', to: 'orders#new', as: :new_order, via: :get

  # message creation route
  resources :messages, only: [:create, :index]

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

    # manage Users, Settings, Account Holders
    resources :users
    resources :settings, only: [:index, :update]
    resources :account_holders
    resources :cards

    # manage Payment Methods + state toggle
    resources :payment_methods do
      collection do
        get 'toggle/:id' => :toggle, as: :toggle
      end
    end

    # manage Orders + history page
    resources :orders do
      collection do
        get 'history' => :history, as: :history
      end
    end

    # manage Orders > Accounts + state toggle
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

  # logged in  -> account page (orders:index)
  # logged out -> statice home page
  root to: 'pages#home'

  # static pages
  get '/home', to: 'pages#home', as: :home
  get '/instrucciones', to: 'pages#howto', as: :howto
  get '/legal', to: 'pages#legal', as: :legal
  get '/preguntas', to: 'pages#faq', as: :faq
  get '/contacto', to: 'pages#contact', as: :contact
  post '/contacto', to: 'pages#send_message', as: :contact_forms

end
