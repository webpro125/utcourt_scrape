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
    get 'court_locations' => 'users#court_locations'
    # resource :users, only: [:update]
    resources :requests, only: [:create, :index]
    resources :request_histories, only: [:index]
  end

  authenticated :admin do
    root 'admin/profiles#scheduled_courts', as: :site_admin
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  namespace :admin do
    get '/' => 'users#index'
    resources :users do
      get :approve
      get :disapprove
    end
    resource :profiles, path: 'profile', only:[:edit, :update] do
      get :scheduled_courts
    end
    resources :requests, only: [:index, :show]
    resources :dashboards, only: [:index]
  end


  post '/pages', to: 'pages#index'
  get '/pages', to: 'pages#index'
end
