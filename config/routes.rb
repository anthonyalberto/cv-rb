CvRb::Application.routes.draw do
  devise_for :recruiters

  get "home/index"
  root :to => "home#index"
end
