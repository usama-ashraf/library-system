Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_for :admins, ActiveAdmin::Devise.config

  # below code to fix the active admin issue when table not exists in database as activeadmin tries to load every model.
  # for reference https://github.com/activeadmin/activeadmin/issues/783
  begin
    ActiveAdmin.routes(self)
  rescue Exception => e
    puts "ActiveAdmin: #{e.class}: #{e}"
  end
  # root to: "home#index"
  root to: "admin/dashboard#index"

  resources :books do
    member do
      get :upload_books_csv
      post :add_books_data
    end
  end

  namespace :api do
    namespace :v1 do
      resource :users, only:[] do
        collection do
          post :sign_up
          post :sign_in
          post :reset_password
          post :forgot_password
          post :search_book
          post :reserve_book
          post :show_book
          delete :destroy
          get :books_list
          post :reserve_books
          post :book_suggestion
        end
      end
    end
  end

end
