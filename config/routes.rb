Rails.application.routes.draw do
  devise_for :people, path: 'auth'
  devise_scope :person do
    get 'auth', to: 'devise/registrations#new'
  end
  authenticate :person do
    resources :courses do
      get "enrollments/enrollment_existing" => 'enrollments#enrollment_existing', :as => :enrollment_existing
      get "enrollments/enrollment_new" => 'enrollments#enrollment_new', :as => :enrollment_new
      resources :enrollments
      resources :assignments do
        resources :grades
      end
    end
    resources :people

    root to: 'courses#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
