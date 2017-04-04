Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get 'users/dashboard', to: 'users#dashboard', as: 'user_dashboard'
  post 'users/add_users' => 'users#add_users'

  get 'contracts/new'
  get 'contracts/index'
  get 'contracts/:id/:link(.:format)', to: 'contracts#show', as: 'contracts_show'
  post 'contracts' => 'contracts#create'
  post 'contracts/update' => 'contracts#update'
  delete 'contracts/delete', to: 'contracts#destroy', as: 'contracts_delete'

  post 'answers/edit/all' => 'answers#edit_all', as: :answers_edit_all
  get 'answers/new', to: 'answers#new', as: 'new_answers'
  get 'answers/index'
  post 'answers' => 'answers#create'

  get 'decisions/new'
  get 'decisions/index'
  get 'decisions/show' => 'decisions#show'
  post 'decisions/update' => 'decisions#update'
  post 'decisions' => 'decisions#create'
  delete 'decision/delete' => 'decisions#destroy'


end
