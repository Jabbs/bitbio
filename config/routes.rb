Bitbio::Application.routes.draw do
  
  resources :messages, only: [:show]
  resources :users do
    resources :messages, only: [:create, :index]
  end
  resources :projects
  resources :comments
  
  match '/researchers', to: 'users#researchers_index', via: :get
  match '/providers', to: 'users#providers_index', via: :get

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root :to => 'projects#index'
end
