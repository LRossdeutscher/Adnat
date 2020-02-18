Rails.application.routes.draw do
    get 'log_out' => 'sessions#destroy', :as => "log_out"
    get 'log_in' => 'sessions#new', :as => "log_in"
    get 'sign_up' => 'users#new', :as => "sign_up"
    get 'welcome' => 'sessions#welcome', :as => "welcome"
    get 'overview' => 'sessions#overview', :as => "overview"
    put 'leave/:id' => 'users#leave_organisation', :as => "leave_organisation"
    put 'join/:id' => 'users#join_organisation', :as => "join_organisation"

    root :to => "sessions#overview"

    resources :users
    resources :sessions
    resources :organisations
    resources :shifts
end
