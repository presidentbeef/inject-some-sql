Queries = [
  {
    :action => :calculate,
    :query => "Order.calculate(:sum, params[:column])",
    :input => [:name => :column, :example => 'blah']
  },

  {
    :action => :conditions_string,
    :query => 'User.first(:conditions => "name = \'#{params[:name]}\'")',
    :input => [:name => :name, :example => "name=') or 1=1--"]
  },

  { :action => :exists },

  {
    :action => :from_option,
    :query => "User.all(:from => params[:from]).where(:admin => false)",
    :input => [:name => :from, :example => "from=users--"]
  },

  {
    :action => :group_option,
    :query => "User.find(:all, :group => params[:group], :where => { :admin => false })",
    :input => [:name => :group, :example => "group=name UNION SELECT * FROM users"]
  },

  {
    :action => :having,
    :query => 'Order.where(:customer_id => current_user).group(:customer_id).having("total > #{params[:total]}")',
    :input => [:name => :total, :example => "total=1 UNION SELECT * FROM orders"]
  },

  {
    :action => :having_option,
    :query => 'Order.all(:conditions => { :customer_id => current_user }, :group => :customer_id, :having => "total > #{params[:total]}")',
    :input => [:name => :total, :example => "total=1 UNION SELECT * FROM orders"]
  },

  {
    :action => :joins,
    :query => 'Order.where(:customer_id => current_user).joins(params[:table])',
    :input => [:name => :table, :example => "table=,users--"]
  },

  {
    :action => :lock_option
  },

  {
    :action => :order,
    :query => 'User.all.order("name #{params[:sort]}")',
    :input => [:name => :sort, :example => ',8']
  },

  {
    :action => :order_option,
    :query => 'User.all(:order => "name #{params[:sort]}")',
    :input => [:name => :sort, :example => ',8']
  },

  {
    :action => :select_option,
    :query => 'User.first(:conditions => { :name => params[:name], :password => params[:password] }, :select => params[:column])',
    :input => [:name => :column, :example => '* FROM users--']
  },

  {
    :action => :where,
    :query => 'User.all(:order => "name #{params[:sort]}")',
    :input => [:name => :sort, :example => "') OR 1--"]
  },

  {
    :action => :update_all,
    :query => 'User.update_all(params[:update])',
    :input => [:name => :update, :example => "admin=1"]
  },

  {
    :action => :update_all_order_option,
    :query => 'User.update_all("admin = 1", "name LIKE \'B%\'" , { :order => params[:order] })'
  },

  {
    :action => :update_all_thing,
    :query => 'User.update_all(:name => params[:name])',
    :input => [:name => :name]
  }
]
