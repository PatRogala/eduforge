Rails.application.routes.draw do
  devise_for :users

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
    mount PgHero::Engine, at: "pghero"
  end

  # Instructor routes to manage created courses
  namespace :instructor do
    resources :courses, only: [:new]
    resources :programming_courses, only: [:index, :new, :create]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
