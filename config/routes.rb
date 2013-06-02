Bitbio::Application.routes.draw do
  
  get "tags/index"

  resources :instruments


  resources :messages, only: [:show]
  resources :users do
    get 'resend'
    get 'project_listings'
    resources :messages, only: [:create, :index]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :projects do
    collection do
      get 'tags'
    end
  end
  resources :tags, only: [:index]
  get 'tags/:tag', to: 'tags#show', as: :tag
  resources :comments
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
