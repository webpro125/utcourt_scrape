Rails.application.routes.draw do
  devise_for :admins, path: '/admin',
             path_names: { sign_in: 'login', sign_out: 'logout'},
             controllers: { sessions: 'admin/sessions'},
             :skip => [:registrations]
  devise_for :users, path: '/', path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       sign_up: 'registration'
                   },
       controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  namespace :api do
    post 'auth_user' => 'authentication#authenticate_user'
    post 'register_user' => 'authentication#register_user'
    get 'user_info' => 'users#user_info' #test
    post 'users' => 'users#update'
    # resource :users, only: [:update]
    resources :requests, only: [:create]

  end
  authenticated :admin do
    root 'admin/users#index', as: :site_admin
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  namespace :admin do
    get '/' => 'users#index'
    resources :users do
      get :approve
    end
    resource :profiles, path: 'profile', only:[:edit, :update]
    # resources :dashboards, only: [:index]
  end


  post '/pages', to: 'pages#index'
  get '/pages', to: 'pages#index'
end
