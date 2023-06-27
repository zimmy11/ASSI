Rails.application.routes.draw do
  resources :bans
  resources :users do
    resources :drafts
    resources :presales
    resources :org_events
    resources :saves
  end
  resources :events do
      resources :evaluations
  end
  root :to =>redirect("/events")


  
 


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
