Rails.application.routes.draw do

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/' => 'users#index'
  get '/login' => 'sessions#new'
  post'/sessions/login' => 'sessions#create'
  get '/vehicles/welcome/' => 'vehicles#welcome'
  post '/users' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  get '/bike/new' => 'vehicles#new'
  get '/bike/update' => 'vehicles#show'
  get '/bike/delete' => 'vehicles#show'
  get '/vehicle/delete/:id' => 'vehicles#destroy'
  get '/bike/update/:id' => 'vehicles#destroy'
  get '/service/delete/:id' => 'servicerequests#destroy'
  get '/bike/show' => 'vehicles#show'
  get '/vehicles/insert' => 'vehicles#insert'
  get '/admin/welcome' => 'admins#welcome'
  get '/employee/welcome' => 'employees#welcome'
  post '/vehicles/insert' => 'vehicles#insert'
  post '/service/add/:id' => 'servicerequests#book'
  get '/service/add/:id/dates' => 'servicerequests#date'
  get '/service/booked' => 'servicerequests#booked'
  get '/vehicles/:id/edit' => 'vehicles#edit'
  patch '/vehicles/:id' => 'vehicles#update'
  get '/admin/add/employee' => 'admins#employee'
  get '/admin/add/admin' => 'admins#admin'
  get '/admin/viewservices' => 'servicerequests#servicerequest'
  get '/user/logout' => 'sessions#destroy'
  get '/vehicles/alert' => 'vehicles#alert'
  # get'/admin/assignservice' 
  resources :users, except: [:new]
  # post '/login' => 'validates#index'
end
