SocialNetwork::Application.routes.draw do
  post  '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  root 'users#show'
  
  resources :posts
  get "post" => 'posts#destroy'
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:new, :create, :destroy]
  resources :images, only: [:create, :destroy]
  
  resources :users do 
    delete 'friend' => 'friends#destroy'
    put 'friend' => 'friends#update'
    resources :friends, only: [:create, :destroy]
    resource :profiles  
  end
  
end
