Station::Application.routes.draw do
  root 'home#index'

  get   '/about'    => 'home#about'
  match '/login'    => 'home#login', :via => [:get, :post]
  match '/register' => 'home#register', :via => [:get, :post]
  match '/logout'   => 'home#logout', :via => [:get, :post]
end
