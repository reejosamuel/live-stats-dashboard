Rails.application.routes.draw do

  devise_for :users
  post "push", to: 'rooms#push'

  authenticate :user do
    root to: 'rooms#show', as: :authenticated_root
  end


  root to: 'rooms#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
