CvRb::Application.routes.draw do
  get "shell/index"
  post "shell/update"

  devise_for :recruiters

  get "home/index"
  root :to => "home#index"
end
