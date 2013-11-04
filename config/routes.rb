Bitbio::Application.routes.draw do

  resources :connection_requests, only: [:create]
  match "/connection_reply", to: "connection_requests#reply", via: :get
  
  # static pages
  match '/about', to: 'static_pages#about', via: :get
  match '/how_it_works', to: 'static_pages#how_it_works', via: :get
  match '/privacy', to: 'static_pages#privacy', via: :get
  match '/terms', to: 'static_pages#terms', via: :get
  match '/press', to: 'static_pages#press', via: :get

  resources :contacts

  resources :invitations, only: [:new, :create]

  resources :events do
    resources :comments, only: [:create]
    collection do
      get 'tags', to: 'tags#index_events', as: :tags
      get 'tags/:tag', to: 'tags#show_events', as: :tag
    end
  end

  resources :facilities do
    resources :labs
  end
  mount Ckeditor::Engine => '/ckeditor'

  resources :services do
    collection do
      get 'tags', to: 'tags#index_services', as: :tags
      get 'tags/:tag', to: 'tags#show_services', as: :tag
    end
  end
  resources :attachments
  resources :blogs do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :index]
    collection do
      get 'tags', to: 'tags#index_blogs', as: :tags
      get 'tags/:tag', to: 'tags#show_blogs', as: :tag
    end
  end
  resources :instruments
  resources :messages, only: [:show]
  resources :users, path: "/members" do
    get 'resend'
    get 'project_listings'
    get 'service_listings'
    get 'connections', to: "users#all_connections"
    resources :messages, only: [:create, :index]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :projects do
    get 'activate'
    resources :comments, only: [:create] do
      resources :likes, only: [:create, :index]
    end
    collection do
      get 'information'
      get 'tags', to: 'tags#index_projects', as: :tags
      get 'tags/:tag', to: 'tags#show_projects', as: :tag
    end
  end
  resources :verifications, only: [:show]
  
  match '/researchers', to: 'users#researchers_index', via: :get
  match '/providers', to: 'users#providers_index', via: :get

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  
  if ENV["ALPHA"] == "true"
    root :to => 'static_pages#coming_soon'
  else
    root :to => 'projects#home'
  end
  # root :to => 'static_pages#coming_soon'
end
