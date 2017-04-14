Rails.application.routes.draw do

  devise_for :users, controllers: { passwords: :passwords }

  devise_scope :user do

    get '/users/slack_callback' => 'sessions#slack_callback'

    authenticated :user do
      root 'dashboard#index'
    end
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :interviewees, except: [:destroy], concerns: [:paginatable] do
    resources :activities, only: [:index, :create]

    collection do
      get :result
      get :calendar
    end
  end

  resources :positions, except: [:show]
  resources :dashboard, only: [:index]
  resource :user, only: [:edit, :update]

  scope 'pre-interview', controller: 'pre_interview', as: 'pre_interview' do
    get 'consent/:token', action: :consent, as: 'consent'
    get 'edit/:token', action: :edit, as: 'edit'
    patch 'update/:token', action: 'update', as: 'update'
    get 'complete', action: 'complete', as: 'complete'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
