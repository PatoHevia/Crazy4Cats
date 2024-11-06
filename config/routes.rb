Rails.application.routes.draw do
  devise_for :users
  
  resources :posts do
    member do
      post 'like', to: 'posts#like'
      post 'dislike', to: 'posts#dislike'
    end

    # Rutas anidadas para comentarios en publicaciones
    resources :comments, only: [:create]
  end

  # Define la página de inicio
  root "posts#index"
end
