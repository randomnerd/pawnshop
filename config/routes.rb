Rails.application.routes.draw do
  root 'items#index'

  resources :items
  devise_for :admins

  namespace :hq do
    root 'items#index'

    resources :items do
      member { get :decline }
    end
  end

end
