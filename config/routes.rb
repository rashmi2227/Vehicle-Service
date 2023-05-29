Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :user_logins  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  devise_for :user_logins, controllers: {
    sessions: 'user_logins/sessions',
    registrations: 'user_logins/registrations'
  }

  devise_scope :user_login do
    root to: 'user_logins/sessions#new'
  end

  # root to: 'user_logins/sessions#new'
  get '/login' => 'sessions#new'
  post'/sessions/login' => 'sessions#create'
  get '/vehicles/welcome/' => 'vehicles#welcome'
  post '/users' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  get '/bike/new' => 'vehicles#new'
  get '/bike/update' => 'vehicles#show'
  get '/bike/delete' => 'vehicles#show'
  get '/vehicle/delete/:id' => 'vehicles#destroy'
  # get '/bike/update/:id' => 'vehicles#destroy'
  get '/service/delete/:id' => 'servicerequests#destroy'
  get '/service/delete/:id/check' => 'service_handlers#check'
  get '/bike/show/' => 'vehicles#show'
  get '/vehicles/create' => 'vehicles#create'
  get '/admin/welcome' => 'admins#welcome'
  get '/employee/welcome' => 'employees#welcome'
  post '/vehicles/create' => 'vehicles#create'
  post '/service/add/:id' => 'servicerequests#create'
  post '/service/add' => 'servicerequests#create'
  get '/service/add/:id/dates' => 'servicerequests#date'
  get '/service/booked' => 'servicerequests#showbookedservice'
  get '/vehicles/:id/edit' => 'vehicles#edit'
  patch '/vehicles/:id' => 'vehicles#update'
  get '/admin/add/employee' => 'admins#employee'
  get '/admin/add/admin' => 'admins#admin'
  get '/admin/viewservices' => 'servicerequests#show'
  get '/admin/assign/:id' => 'admins#assign'
  get '/user/logout' => 'sessions#destroy'
  get '/vehicles/alert' => 'vehicles#alert'
  post '/serviceassigned/:id' => 'service_handlers#create'
  get '/serviceassigned/show' => 'service_handlers#index'
  get '/admin/check/:id' => 'admins#check'
  get '/pending/service' => 'servicerequests#showpendingservice'
  get '/service_handler/existing' => 'service_handlers#existing'
  post '/employee/register' => 'admins#createmployee'
  post '/admin/register' => 'admins#createadmin'
  get '/admin/assignservice' => 'admins#assignservice'
  post '/check/serviceid' => 'admins#checkservice'
  post '/status/serviceid' => 'employees#checkservice'
  get '/service/edit/:id' => 'service_handlers#edit'
  get '/service/edit/:id/check' => 'service_handlers#checkstatus'
  patch '/edithandlers/:id' => 'service_handlers#update'
  get '/update/status/:id' => 'servicerequests#liststatus'
  get '/update/status' => 'employees#updatestatus'
  patch '/update/status/:id' => 'servicerequests#update'
  get '/view/all/service' =>  'servicerequests#index'
  get 'vehicle/view' => 'employees#vehicle'
  post '/employees/check/vehicle' => "vehicles#checkvehicle"
  get '/vehicle/details/:id' => "vehicles#details"
  get '/add/payment' => 'payments#form'
  post '/payment/check' => 'payments#check'
  get 'payment/add/amount/:id' => 'payments#amount'
  get 'payment/status' => 'payments#index'
  post 'payment/add/:id' => 'payments#create'
  get 'payments/show' => 'payments#index'
  get '/payments/all' => 'payments#show'
  get '/payments/:id/pay' => 'payments#confirm'
  get '/payments/:id/check' => 'payments#checkstatus'
  get 'user/payment/pay/:id' => 'payments#update'
  get '/user/review' => 'reviews#write'
  post '/reviews/add' => 'reviews#create'
  get '/view/reviews' => 'reviews#show'
  get '/service_handlers/assigned' => 'service_handlers#alert'
  get '/service/add/:id/check' => 'servicerequests#checkserviceexisting'
  get '/service/vehicle/assigned' => 'servicerequests#alert'
  get '/view/employees' => 'users#view'
  get '/admin/view/reviews' => "reviews#index"
  get '/service/done' => 'servicerequests#done'
  get '/vehicle/notfound' => 'vehicles#notfound'
  get '/employee/error' => 'employees#error'
  get '/payment/done' => 'payments#done'
  get '/vehcile/service/done' => 'vehicles#done'
  get '/payment/amount/edit/:id' => 'payments#edit'
  patch '/payment/update/amount/:id' => "payments#updateamount"
  get '/payments/:id/check/amount' => 'payments#checkamount'
  get 'payment/invalid/serviceno' => "payments#invalidservice"
  get '/payments/delete/:id' => 'payments#destroy'
  get '/payment/over' => 'payments#paymentdone'
  get '/service/edit' => 'service_handlers#done'

  scope :api do
    use_doorkeeper do
        skip_controllers :applications, :authorizations, :authorized_applications
    end
  end

  use_doorkeeper do
    skip_controllers :authorizations, :authorized_applications
  end

  namespace :api , default: {format: :json} do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    # devise_for :user_logins  
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
    # Defines the root path route ("/")
    
    devise_for :user_logins, controllers: {
      sessions: 'user_logins/sessions',
      registrations: 'user_logins/registrations'
    }
  
    devise_scope :user_login do
      root to: 'sessions#new'
    end
  
    # root to: 'user_logins/sessions#new'
    get '/login' => 'sessions#new'
    post'/sessions/login' => 'sessions#create'
    get '/vehicles/welcome/' => 'vehicles#welcome'
    # post '/users' => 'users#create'
    delete '/logout' => 'sessions#destroy'
    get '/bike/new' => 'vehicles#new'
    get '/bike/update' => 'vehicles#show'
    get '/bike/delete' => 'vehicles#show'
    delete '/vehicle/delete/:id' => 'vehicles#destroy'
    get '/bike/update/:id' => 'vehicles#destroy'
    delete '/service/delete/:id' => 'servicerequests#destroy'
    get '/service/delete/:id/check' => 'service_handlers#check'
    get '/bike/show' => 'vehicles#show'
    get '/vehicles/create' => 'vehicles#create'
    get '/admin/welcome' => 'admins#welcome'
    get '/employee/welcome' => 'employees#welcome'
    post '/vehicles/create' => 'vehicles#create'
    post '/service/add/:id' => 'servicerequests#create'
    get '/service/add/:id/dates' => 'servicerequests#date'
    get '/service/booked' => 'servicerequests#showbookedservice'
    get '/vehicles/:id/edit' => 'vehicles#edit'
    patch '/vehicles/:id' => 'vehicles#update'
    get '/admin/add/employee' => 'admins#employee'
    get '/admin/add/admin' => 'admins#admin'
    get '/admin/viewservices' => 'servicerequests#show'
    get '/admin/assign/:id' => 'admins#assign'
    get '/user/logout' => 'sessions#destroy'
    get '/vehicles/alert' => 'vehicles#alert'
    post '/serviceassigned/:id' => 'service_handlers#create'
    get '/serviceassigned/show' => 'service_handlers#index'
    get '/admin/check/:id' => 'admins#check'
    get '/pending/service' => 'servicerequests#showpendingservice'
    get '/service_handler/existing' => 'service_handlers#existing'
    post '/employee/register' => 'admins#createmployee'
    post '/admin/register' => 'admins#createadmin'
    get '/admin/assignservice' => 'admins#assignservice'
    post '/check/serviceid' => 'admins#checkservice'
    post '/status/serviceid' => 'employees#checkservice'
    get '/service/edit/:id' => 'service_handlers#edit'
    patch '/edithandlers/:id' => 'service_handlers#update'
    get '/update/status/:id' => 'servicerequests#liststatus'
    get '/update/status' => 'employees#updatestatus'
    patch '/update/status/:id' => 'servicerequests#update'
    get '/view/all/service' =>  'servicerequests#index'
    get 'vehicle/view' => 'employees#vehicle'
    post '/employees/check/vehicle' => "vehicles#checkvehicle"
    get '/vehicle/details/:id' => "vehicles#details"
    get '/add/payment' => 'payments#form'
    post 'payment/check' => 'payments#check'
    get 'payment/add/amount/:id' => 'payments#amount'
    get 'payment/status' => 'payments#index'
    post 'payment/add/:id' => 'payments#create'
    get 'payments/show' => 'payments#index'
    get '/payments/all' => 'payments#show'
    get '/payments/:id/pay' => 'payments#confirm'
    get '/payments/:id/check' => 'payments#checkstatus'
    patch 'user/payment/pay/:id' => 'payments#update'
    get '/user/review' => 'reviews#write'
    post '/reviews/add' => 'reviews#create'
    get '/view/reviews' => 'reviews#show'
    get '/service_handlers/assigned' => 'service_handlers#alert'
    get '/service/add/:id/check' => 'servicerequests#checkserviceexisting'
    get '/service/vehicle/assigned' => 'servicerequests#alert'
    get '/view/employees' => 'users#view'
    get '/admin/view/reviews' => "reviews#index"
    delete '/reviews/delete/:id' => "reviews#destroy"
    get '/service/done' => 'servicerequests#done'
    get '/vehicle/notfound' => 'vehicles#notfound'
    get '/employee/error' => 'employees#error'
    get '/payment/done' => 'payments#done'
    get '/vehcile/service/done' => 'vehicles#done'
    get '/payment/amount/edit/:id' => 'payments#edit'
    patch '/payment/update/amount/:id' => "payments#updateamount"
    get '/payments/:id/check/amount' => 'payments#checkamount'
    delete '/payments/delete/:id' => 'payments#destroy'
    get '/reviews/user' => 'reviews#user_reviews'
    get '/reviews/service' => 'reviews#service_reviews'
    get '/service/completed' => 'servicerequests#completed_service'
    get '/view/all/employees' => 'user_logins#employee'
    get '/view/admins' => 'user_logins#admin'
    get '/view/customers' => 'user_logins#customer'
    delete '/delete/service/handler/:id' => 'service_handlers#destroy'
  end


end
