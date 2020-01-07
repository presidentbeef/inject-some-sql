BadSql::Application.routes.draw do
  match 'query/:action', controller: :query
  match 'examples', to: 'query#examples'
  root to: 'query#index'
end
