Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get 'home/about' => 'public/homes#about', as: "about"

  namespace :admin do
    get 'admin/homes/top' => 'homes#top'

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get "withdrawal" => "users#withdrawal"
        patch "out" => "users#out"
      end
    end
    resources :novel_comments, only: [:index, :create, :destroy]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :public do
    resources :novels, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :tags, only: [:index, :create, :edit, :update, :destroy, :show]
      get 'tag_search'
      resources :novel_comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
      resources :bodies, only: [:new, :show, :create, :edit, :update, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
    end
  end

end