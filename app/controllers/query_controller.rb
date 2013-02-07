class QueryController < ApplicationController
  after_filter :reset_database, :except => [:index, :examples]

  def index
    @queries = Queries
  end

  def examples
    @queries = Queries.map do |q|
      params[q[:input][:name]] = q[:input][:example]

      result = q.dup

      begin
        result[:result] = eval(q[:query]).inspect
      rescue => e
        result[:result] = e
      end

      params[q[:input][:name]] = nil
      result[:sql] = last_sql

      reset_database

      result
    end

    render :layout => 'examples'
  end

  Queries.each do |query|
    class_eval <<-RUBY
      def #{query[:action]}
        begin
          show #{query[:query]}
        rescue => e
          @error = e
          @sql = last_sql
          render :partial => 'error'
        end
      end
    RUBY
  end

  private

  def show query
    @sql = last_sql
    render :partial => 'result', :locals => { :query => query }
  end

  def last_sql
    sql = $last_sql
    $last_sql = nil
    sql
  end

  def reset_database
    Order.delete_all
    User.delete_all
    load File.join(Rails.root, 'db/seeds.rb')
  end
end
