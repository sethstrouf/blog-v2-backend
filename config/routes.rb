Rails.application.routes.draw do
  resources :comments, only: %i[index create destroy]
  resources :posts
  post 'posts/:id/attach_images', to: 'posts#attach_images'
  post 'posts/:id/delete_image', to: 'posts#delete_image'

  resources :api_keys, path: 'api_keys', only: %i[index create destroy]
end
