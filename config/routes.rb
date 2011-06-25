Fire333::Application.routes.draw do
  match '/' => "Site#index", :as => "root"
  match '/login' => "Site#login"
  match '/logout' => "Site#logout"
  match '/preferences' => "Site#preferences", :as => "preferences"
  #match '/posts/new' => "Post#new"
  match 'new_post' => "Post#new"
  match '/post/:id' => "Post#show"
  match 'new_event' => "Event#new"
  match '/event/:id' => "Event#show"
  match '/attachment/create' => "Attachment#create", :as => "new_attachment"
  match '/attachment/:id' => "Attachment#show", :as => "show_attachment"
  #resource :posts
end
