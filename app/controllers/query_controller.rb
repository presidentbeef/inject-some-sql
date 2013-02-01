class QueryController < ApplicationController
  def index
  end

  def all
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

  #
  def from
    show User.all(:from => params[:from]).where(:admin => false)
  end

  def group
    show User.find(:all, :group => params[:group], :where => { :admin => false})
  end

  def having
    show Order.where(:customer_id => current_user).group(:customer_id).having("total > #{params[:total]}")
  end

  def having_option
    show Order.all(:conditions => { :customer_id => current_user }, :group => :customer_id, :having => "total > #{params[:total]}")
  end

  def joins
    show Order.where(:customer_id => current_user).joins(params[:table])
  end

  def order
    show User.all.order("#{params[:column]} #{params[:sort]}")
  end

  def order_option
    show User.all(:order => "name #{params[:sort]}")
  end

  def select_option
    show User.first(:conditions => { :name => params[:name], :password => params[:password] }, :select => params[:column])
  end

  def where
    show User.where("name = '#{params[:name]}' AND password = '#{params[:password]}'")
  end

  def update_all
    show User.update_all(params[:update])
  end

  def update_all_order_option
    show User.update_all("admin = 1", "name LIKE 'B%'" , { :order => params[:order] })
  end

  private

  def show query
    render 'show', :locals => { :query => query }
  end
end
