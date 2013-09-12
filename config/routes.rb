Trl::Application.routes.draw do
  resources :attachments 

  resources :comments do
    member do
      get 'modify'
    end
  end

  resources :posts do
    collection do
      get 'add_comment'
      get 'add_attachment'
    end
  end
    
  authenticated :user do
#    root :to => 'home#index'
    root :to => 'home#start'
  end
  root :to => "home#start"
  devise_for :users
  resources :users
  
#  get 'home/welcome' => 'home#welcome', :as => :welcome
#  get 'home/index' => 'home#index', :as => :index  
  get 'home/start' => 'home#start', :as => :start

end