Queries = [
  {
    :action => :calculate,
    :query => "Order.calculate(:sum, params[:column])",
    :input => [:name => :column, :example => "blah"]
  },

  {
    :action => :conditions_string,
    :query => 'User.first(:conditions => "name = \'#{params[:name]}\'")'
  },

  { :action => :exists },

  {
    :action => :from_option,
    :query => "User.all(:from => params[:from]).where(:admin => false)"
  },

  {
    :action => :group_option,
    :query => "User.find(:all, :group => params[:group], :where => { :admin => false })"
  },

  {
    :action => :having,
    :query => 'Order.where(:customer_id => current_user).group(:customer_id).having("total > #{params[:total]}")'
  },

  {
    :action => :having_option,
    :query => 'Order.all(:conditions => { :customer_id => current_user }, :group => :customer_id, :having => "total > #{params[:total]}")'
  },

  {
    :action => :joins,
    :query => 'Order.where(:customer_id => current_user).joins(params[:table])'
  },

  {
    :action => :lock_option
  },

  {
    :action => :order,
    :query => 'User.all.order("#{params[:column]} #{params[:sort]}")'
  },

  {
    :action => :order_option,
    :query => 'User.all(:order => "name #{params[:sort]}")'
  },

  {
    :action => :select_option,
    :query => 'User.first(:conditions => { :name => params[:name], :password => params[:password] }, :select => params[:column])'
  },

  {
    :action => :where,
    :query => 'User.all(:order => "name #{params[:sort]}")'
  },

  {
    :action => :update_all,
    :query => 'User.update_all(params[:update])'
  },

  {
    :action => :update_all_order_option,
    :query => 'User.update_all("admin = 1", "name LIKE \'B%\'" , { :order => params[:order] })'
  }
]
