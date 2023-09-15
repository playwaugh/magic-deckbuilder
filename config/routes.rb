Rails.application.routes.draw do
  devise_for :users
  resources :decks
  resources :cards, only: :show
  root to: "decks#index"
end
