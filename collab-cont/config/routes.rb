Rails.application.routes.draw do
  get 'home/index'
  get 'contracts/new'
  get 'contracts/index'
  get 'contracts/:id' => "contracts#show" 
  post "contracts" => "contracts#create"


  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
