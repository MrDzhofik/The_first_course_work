Rails.application.routes.draw do
  root 'show#choice'
  get 'show/department'
  get 'show/discipline'
  get 'show/teacher'
  get 'show/student'
  get 'show/mark'
  get 'show/kudo'
  get 'show/reprimand'
  get 'show/group'
  get 'show/n1'
  get 'show/n2'
  get 'show/n3'
  get 'show/n4'
  get 'show/n5'
  get 'show/n6'
  get 'show/n7'
  get 'show/input5'
  get 'show/input6'
  get 'show/input7'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
