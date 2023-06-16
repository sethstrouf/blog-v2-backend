Rails.application.routes.draw do
  resources :comments, only: %i[index create destroy]
  resources :posts
end
