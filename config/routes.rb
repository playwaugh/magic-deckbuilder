Rails.application.routes.draw do
  devise_for :users
  resources :decks
  resources :cards, only: :show
end
