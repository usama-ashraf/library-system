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
  root to: "home#index"

  namespace :api do
    namespace :v1 do
      resource :users, only:[] do
        collection do
          post :sign_up
          post :sign_in
          post :reset_password
          post :forgot_password
          post :search_book
        end
      end
    end
  end

end
