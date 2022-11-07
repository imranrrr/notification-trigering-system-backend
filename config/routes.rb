Rails.application.routes.draw do
  resources :templates
  get '/current_user', to: 'current_user#index'
  
  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
    }


  devise_for :users, only: [:sessions, :registrations],controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # devise_scope :user do 
  #   post   'users/sign_up',  to: 'users/registrations#create'
  # end
end
