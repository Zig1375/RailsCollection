Rails.application.routes.draw do
    devise_for :users, skip: :all

    devise_scope :user do
        get  'users/sign_in',  to: 'users/sessions#new'
        post 'users/sign_in', to: 'users/sessions#create'
        delete 'users/sign_in', to: 'users/sessions#destroy'
    end

    resources :collections do
        get :cart, to: 'cart#show'
        post :cart, to: 'cart#create'

        resources :items do
            post :swap
        end
        resources :requests do
            post :item, path: "item/:item_id", to: 'requests#item'
            post :state, path: "state/:state", to: 'requests#state'
        end

        resources :categories

    end

    root "collections#index"
end
