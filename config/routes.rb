Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  
  
  
  resources :users do
    resources :drafts
    resources :saves
    resources :presales
    resources :bans
  end
  resources :events  do
      resources :evaluations

      
  end
  root to: 'events#index'
  post "/events", to: "events#create",as: "create_event"
  delete "/users/:user_id/:event_id/saves", to: "saves#destroy",as: "delete_saves"
  post "/events/:event" ,to: "events#create",as: "draft_event"
  post "events/:event_id/create_order", to: "presales#create_order",as: "create_order"
  get "presales/capture_order", to: "presales#capture_order"
  get "presales/cancel_order", to: "presales#cancel_order"
  get "events/:event_id/presales",to: "presales#index",as: "all_presales"
  get "events/:role",to: "events#index",as: "index_events"
  get "users/:user_id/create_order",to: "users#create_order",as: "premium"
  post "/events/:event_id/evaluations/:value", to: "evaluations#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
