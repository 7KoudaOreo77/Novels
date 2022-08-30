Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: "public/homes#top"
  get 'home/about' => 'public/homes#about', as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
