Rails.application.routes.draw do
  devise_for :users

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do\
    resources :events
    post "login" => "auth#login"
    post "logout" => "auth#logout"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
