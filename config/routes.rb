SocialNetwork::Application.routes.draw do
  
  devise_for :users, controllers: {registrations: 'users/registrations'}

  root 'users#show'
  
  resources :posts
  resources :likes, only: [:create, :destroy]
  resources :comments
  
  resources :users do 
    delete 'friend' => 'friends#destroy'
    put 'friend' => 'friends#update'
    resources :friends, only: [:create, :destroy]
    resource :profiles, only: [:edit, :update]  
  end
  
end
