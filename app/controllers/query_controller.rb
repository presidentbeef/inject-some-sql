class QueryController < ApplicationController
  def index
    @queries = Queries
  end

  Queries.each do |query|
    class_eval <<-RUBY
      def #{query[:action]}
        begin
          show #{query[:query]}
        rescue => e
          @error = e
          @sql = last_sql
          render 'error'
        end
      end
    RUBY
  end

  private

  def show query
    @sql = last_sql
    render 'show', :locals => { :query => query }
  end

  def last_sql
    sql = $last_sql
    $last_sql = nil
    sql
  end
end
