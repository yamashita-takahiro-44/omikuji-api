Rails.application.routes.draw do
  post 'fortunes', to: 'fortunes#index'
end
