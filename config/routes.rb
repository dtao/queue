Station::Application.routes.draw do
  root 'home#index'

  get   '/about'    => 'home#about'
  match '/login'    => 'home#login', :via => [:get, :post]
  match '/register' => 'home#register', :via => [:get, :post]
  match '/logout'   => 'home#logout', :via => [:get, :post]

  get   '/auth/:provider/callback' => 'auth#callback'

  post '/tasks/:id/complete' => 'tasks#complete', :as => 'complete_task'
  post '/tasks/:id/pass'     => 'tasks#pass', :as => 'pass_task'

  resources :tasks
end
