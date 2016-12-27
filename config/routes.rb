Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  get 'contracts/new'
  get 'contracts/index'
  get 'contracts/:id/:link(.:format)', to: "contracts#show", as: 'contracts_show'
  post 'contracts' => "contracts#create"
  post 'contracts/update' => "contracts#update"

  post 'answers/edit/all' => "answers#edit_all", as: :answers_edit_all
  get 'answers/new', to: 'answers#new', as: 'new_answers'
  get 'answers/index'
  post 'answers' => "answers#create"

  get 'decisions/new'
  get 'decisions/index'
  get 'decisions/show' => "decisions#show"
  post 'decisions/update' => "decisions#update"
  post 'decisions' => "decisions#create"
  delete 'decision/delete' => "decisions#destroy"


  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
