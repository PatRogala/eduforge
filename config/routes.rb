require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
    mount Sidekiq::Web, at: "/sidekiq"
  end

  # Lookbook is an open source UI development tool that helps you build modular front-end UIs in Ruby on Rails applications.
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # Instructor routes to manage created courses
  namespace :instructor do
    resources :courses, only: %i[new]
    resources :programming_courses, except: %i[destroy] do
      resources :lessons, controller: "programming_course_lessons", only: %i[new create edit update]
    end
  end

  # Generic routes for courses
  resources :courses, only: %i[index] do
    collection do
      get :my_courses
    end
  end

  resources :programming_courses, only: %i[show]
  resources :programming_course_enrollments, only: %i[create]

  resources :programming_course_lessons, only: %i[show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
