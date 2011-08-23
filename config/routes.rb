Fire333::Application.routes.draw do
  match '/' => "Site#index", :as => "root"
  match '/login' => "Site#login"
  match '/logout' => "Site#logout"
  #match '/:post' => "Site#index"
  match '/preferences' => "Site#preferences", :as => "preferences"
  #match '/posts/new' => "Post#new"
  match 'new_post' => "Post#new"
  match '/post/:id' => "Post#show", :as => "show_post"
  #match '/:id' => "Site#index", :as => "show_post"
  match '/post/delete/:id' => "Post#destroy", :as => "delete_post"
  match 'new_event' => "Event#new"
  match '/event/:id' => "Event#show"
  match '/event/delete/:id' => "Event#destroy", :as => "delete_event"
  match '/attachment/create' => "Attachment#create", :as => "new_attachment"
  match '/attachment/:id' => "Attachment#show", :as => "show_attachment"
  match '/attachment/delete/:id' => "Attachment#destroy", :as => "delete_attachment"
  #resource :posts
  resources :attachments
end
