Rails.application.routes.draw do
  root 'homes#index'
  get '/current_user', to: 'current_user#index'
  
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
    end


  devise_for :users, only: [:sessions, :registrations],controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  namespace :users do 
    resources :templates
  end

  resources :web_signages
  # devise_scope :user do 
  #   post   'users/sign_up',  to: 'users/registrations#create'
  # end
end
