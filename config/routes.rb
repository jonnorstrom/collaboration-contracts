Rails.application.routes.draw do
  get 'home/index'

  get 'contracts/new'
  get 'contracts/index'
  get 'contracts/:id/:link(.:format)', to: "contracts#show", as: 'contracts_show'
  post 'contracts' => "contracts#create"

  get 'answers/new', to: 'answers#new', as: 'new_answers'
  get 'answers/index'
  post 'answers' => "answers#create"

  get 'decisions/new'
  get 'decisions/index'
  get 'decisions/show' => "decisions#show"
  post 'decisions' => "decisions#create"


  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
