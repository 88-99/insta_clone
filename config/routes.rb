Rails.application.routes.draw do
  resources :blogs
    resources :users, only: %i[new create show]
end
