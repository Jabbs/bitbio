Bitbio::Application.routes.draw do

  resources :comments


  resources :users
  match '/researchers', to: 'users#researchers_index', via: :get
  match '/providers', to: 'users#providers_index', via: :get

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :projects
  root :to => 'projects#index'
end
