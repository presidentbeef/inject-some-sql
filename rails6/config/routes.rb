Rails.application.routes.draw do
  post 'query/:action', :controller => :query

  get 'examples' => 'query#examples'

  root :to => 'query#index'
end
