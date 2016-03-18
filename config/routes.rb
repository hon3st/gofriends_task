Rails.application.routes.draw do
  root 'home#index'

  devise_for :employees,
             skip: [:registrations],
             controllers: { sessions: 'employees/sessions' }

  devise_for :users,
             skip: [:sessions, :registrations],
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  as :user do
    delete 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :admin do
    root 'home#index'
    resources :users, only: [:index]
  end
end
