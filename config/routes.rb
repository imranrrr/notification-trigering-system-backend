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
    end


  devise_for :users, only: [:sessions, :registrations],controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  

  namespace :users do 
    resources :templates
  end
  # devise_scope :user do 
  #   post   'users/sign_up',  to: 'users/registrations#create'
  # end
end
