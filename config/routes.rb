Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #トップページはtask一覧(tasks#index)になるように指定
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #ユーザの新規登録ページのURLを/signupにするための設定
  get 'signup', to: 'users#new'
  #ユーザ登録のみであるので、必要なアクションは:createと:newのみ(:newは上で設定)
  resources :users, only: [:create]
  #タスクに必要なアクションは基本的な7つのアクションすべてであるので、以下のように設定
  resources :tasks
end
