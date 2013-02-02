class QueryController < ApplicationController
  def index
    @queries = Queries
  end

  Queries.each do |query|
    class_eval <<-RUBY
      def #{query[:action]}
        show #{query[:query]}
      end
    RUBY
  end

  private

  def show query
    render 'show', :locals => { :query => query }
  end
end
