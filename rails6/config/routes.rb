Rails.application.routes.draw do
  post 'query/:action', controller: :query

  get 'examples', to: 'query#examples'

  root 'query#index'
end
