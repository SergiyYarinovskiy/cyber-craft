Rails.application.routes.draw do
  root 'builds#index'

  resources :builds, only: :index do
    collection do
    	post :import
    	delete :destroy_all
    end
  end
end
