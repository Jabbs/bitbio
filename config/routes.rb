Bitbio::Application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

  resources :attachments
  resources :blogs do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :index]
  end
  get "tags/index"
  resources :instruments
  resources :messages, only: [:show]
  resources :users, except: [:index], path: "/members" do
    get 'resend'
    get 'project_listings'
    resources :messages, only: [:create, :index]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :projects do
    resources :comments, only: [:create]
    collection do
      get 'tags'
    end
  end
  resources :tags, only: [:index]
  get 'tags/:tag', to: 'tags#show', as: :tag
  resources :verifications, only: [:show]
  
  match '/researchers', to: 'users#researchers_index', via: :get
  match '/providers', to: 'users#providers_index', via: :get

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root :to => 'projects#index'
end
