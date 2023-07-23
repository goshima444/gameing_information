Rails.application.routes.draw do


  namespace :admin do
    get 'customers/edit'
    get 'customers/index'
    get 'customers/show'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 # 顧客用.
     scope module: :public do
      root to: "home#top"
        get 'about' => 'home#about'
        get "search" => "searches#search"

    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

        get 'customers/my_page' => 'customers#show'                          #顧客のマイページ.
        get 'customers/information/edit' => 'customers#edit'                 #顧客の登録情報編集画面.
        patch 'customers/information' => 'customers#update'                  #顧客の登録情報更新.
        get 'customers/quit' => 'customers#quit'                             #顧客の退会確認画面.
        patch 'customers/withdraw' => 'customers#withdraw'
      end
# ゲスト
devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

# 管理者用.
      namespace :admin do
        get '/' => "homes#top"

      resources :tags, only: [:index, :create, :edit, :update]
      resources :customers, only:  [:index, :show, :edit, :update]


     end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
