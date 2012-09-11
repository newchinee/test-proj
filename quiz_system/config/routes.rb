QuizSystem::Application.routes.draw do
  devise_for :users
  
  devise_for :admin_users
  
  resources :users
  
  resources :admin_users

  resources :results, only: [:edit, :update, :index, :show, :destroy]

  resources :answers, only: []

  resources :questions, only: []

  resources :quizzes

  resources :categories
  
  resources :mains
  
  resources :mains do
    member do
      get 'quizaction'
    end
  end
  
  get "ajax/getanswer"
  
  get "ajax/getselectedanswer"
  
  get "mains/index"
  
  get "mains/quiz"
  
  post "mains/quiz"
  
  post "mains/result"
  
  post "mains/pause"
  
  root              to: 'static_pages#home'
  match '/about',   to: 'static_pages#about'
  match '/quiz',    to: 'mains#index'
  match '/quiz/category/:id', :controller => :mains, :action => :category
  match '/mains/quiz/:id', :controller => :mains, :action => :quiz

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
