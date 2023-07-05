Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  
  
  
  resources :bans
  resources :users do
    resources :drafts
    resources :saves
  end
  resources :events  do
      resources :evaluations
      resources :presales

      
  end
  root to: 'events#index'
  post "/events", to: "events#create",as: "create_event"
  delete "/users/:user_id/:event_id/saves", to: "saves#destroy",as: "delete_saves"
  post "/events/:event" ,to: "events#create",as: "draft_event"
  post "events/:event_id/create_order", to: "presales#create_order",as: "create_order"
  get "presales/capture_order", to: "presales#capture_order"
  get "presales/cancel_order", to: "presales#cancel_order"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
