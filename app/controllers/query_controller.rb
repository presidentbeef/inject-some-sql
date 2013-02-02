class QueryController < ApplicationController
  def index
    @queries = Queries
  end

  #Calculate methods (average, count, maximum, minimum, sum, pluck(?))
  #are shortcuts for calculate. calculate takes any SQL you would like
  #for the second parameter which selects a column.
  def calculate
    show Order.calculate(:sum, params[:column])
  end

  #Conditions strings are not escaped.
  def conditions_string
    show User.first(:conditions => "name = '#{params[:name]}'")
  end

  def exists
  end

  #From options are not escaped.
  def from_option
    show User.all(:from => params[:from]).where(:admin => false)
  end

  #Group options are not escaped.
  def group_option
    show User.find(:all, :group => params[:group], :where => { :admin => false})
  end

  #Having is not escaped.
  def having
    show Order.where(:customer_id => current_user).group(:customer_id).having("total > #{params[:total]}")
  end

  #Having options are not escaped.
  def having_option
    show Order.all(:conditions => { :customer_id => current_user }, :group => :customer_id, :having => "total > #{params[:total]}")
  end

  #Joins are not escaped.
  def joins
    show Order.where(:customer_id => current_user).joins(params[:table])
  end

  #Lock option is not escaped, but I think sqlite doesn't support it?
  def lock_option
  end

  #Order is not at all escaped.
  def order
    show User.all.order("#{params[:column]} #{params[:sort]}")
  end

  #Order options are not escaped.
  def order_option
    show User.all(:order => "name #{params[:sort]}")
  end

  #Select options are definitely not escaped.
  def select_option
    show User.first(:conditions => { :name => params[:name], :password => params[:password] }, :select => params[:column])
  end

  #Where is not escaped unless explicitly parameterized.
  def where
    show User.where("name = '#{params[:name]}' AND password = '#{params[:password]}'")
  end

  #Update_all takes straight up SQL.
  def update_all
    show User.update_all(params[:update])
  end

  #You can pass fun options to update_all, too.
  def update_all_order_option
    show User.update_all("admin = 1", "name LIKE 'B%'" , { :order => params[:order] })
  end

  private

  def show query
    render 'show', :locals => { :query => query }
  end
end
