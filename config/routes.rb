Rails.application.routes.draw do
  devise_for :users
  resources :bans
  resources :users do
    resources :drafts
    resources :presales
    resources :org_events
    resources :saves
  end
  resources :events  do
      resources :evaluations
  end
  root :to =>redirect("/events")
  post "/events", to: "events#create",as: "create_event"
  get "/events", to: "events#index",as: "index_event"


  
 


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
