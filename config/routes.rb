Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :decisions
    end
  end
end
