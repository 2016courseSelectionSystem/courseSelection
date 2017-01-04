Rails.application.routes.draw do

  get 'classroom/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'wn#index'
  
  resources :wn_course do
    member do
      get :select
      get :quit
    end
    collection do
	    get :list
    end
  end

  resources :classroom do
    collection do
      get :edit
    end
  end
 
  resources :courses do
    member do
      get :select
      get :quit
      get :opencourse
      get :closecourse
      get :coursedestory
      get :passcourse
      get :nopasscourse 
      get :arrangecourse
      get :arrangeconfirm
      get :applycourse
      get :openselect
      get :closeselect 
    end
    collection do
      get :list
      get :grade
      get :discussion
      get :coursetable
      get :control
      get :openall
      get :closeall
      get :checkroom
      
    end
    resources :discussion do
      resources :comment, only: [:index, :create, :new, :destroy]
    end
  end

  resources :grades, only: [:index, :update] do
    collection do
      get :course
      get :grade_chart_bar
      get :grade_chart_pie
      get :department_chart
      get :excel
      get :show_my_grade
    end
  end

  resources :users



  

  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
  get 'sessions/logout' => 'sessions#destroy'
  post 'courses/checkemptyroom' =>'courses#checkemptyroom'

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
