Rails.application.routes.draw do
  
  get '/current_user', to: 'current_user#index'
  get 'current_user/my_engine'
  
  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
    }

  namespace :admins do 
    resources :templates
    resources :endpoint_groups
    resources :locations
    resources :destinations
    resources :endpoints
    resources :web_signages
    resources :integrations
    resources :users
    resources :ic_mobiles
    resources :notifications, only: %i[index show create destroy]
    resources :companies do 
      member do 
        get :company_users
      end
    end
    resources :transactions, only: %i[index show]
    resources :packages do
      member do
        post :buy_package
      end
      collection do
        post :redirect_request
      end
    end
  end


  devise_for :users, only: [:sessions, :registrations],controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :users do  # add this and overide the omniauth callbacks
    mount_devise_token_auth_for 'User', at: 'auth'
    post 'social_auth/callback', to: 'social_auth#authenticate_social_auth_user' # this is the line where we add our routes
    resources :templates
    resources :notifications, only: %i[index show create destroy]
    resources :subscriptions
    resources :transactions, only: %i[index show]
    resources :manage_users
    resources :locations
    resources :destinations
    resources :endpoint_groups
    resources :web_signages
    resources :endpoints
  end
  # devise_scope :user do 
  #   post   'users/sign_up',  to: 'users/registrations#create'
  # end
end
