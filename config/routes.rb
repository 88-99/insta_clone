Rails.application.routes.draw do
  root 'blogs#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i[ new create destroy ]
  resources :users, only: %i[ new create show edit update]
  mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?
end
