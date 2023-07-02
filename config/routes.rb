Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  
  
  
  resources :bans
  resources :users do
    resources :drafts
    resources :presales
    resources :saves
  end
  resources :events  do
      resources :evaluations
  end
  root to: 'events#index'
  post "/events", to: "events#create",as: "create_event"
  delete "/users/:user_id/:event_id/saves", to: "saves#destroy",as: "delete_saves"
  
 


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
