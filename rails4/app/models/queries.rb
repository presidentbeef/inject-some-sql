Queries = [
  {
    :action => :calculate,
    :name => "Calculate Methods",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/Calculations.html#method-i-calculate",
    :query => "Order.calculate(:sum, params[:column])",
    :input => {:name => :column, :example => "age) FROM users WHERE name = 'Bob';"},
    :example => "This example finds the age of a specific user, rather than the sum of all user ages.",
    :desc => <<-MD
There are several methods based around `ActiveRecord::Calculations#calculate`.

`calculate` takes an operation, a column name, and an options hash similar to `ActiveRecord::FinderMethods#find`. Methods based on `calculate` are shortcuts for different operations, and take a column name and options hash as arguments.

In addition to the vulnerable options listed for `find`, the column name argument can also accept SQL!

Calculation methods:

* average
* calculate
* count
* maximum
* minimum
* sum
    MD
  },

  {
    :action => :delete_all,
    :name => "Delete All Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/Associations/CollectionProxy.html#method-i-delete_all",
    :query => 'User.delete_all("id = #{params[:id]}")',
    :input => {:name => :id, :example => '1) OR 1=1--'},
    :example => "This example bypasses any conditions and deletes all users.",
    :desc => <<-MD
Any methods which delete records should be used with care!

The `delete_all` method takes the same kind of conditions arguments as `find`.
The argument can be a string, an array, or a hash of conditions. Strings will not
be escaped at all. Use an array or hash to safely parameterize arguments.

Never pass user input directly to `delete_all`.
    MD
  },

  {
    :action => :destroy_all,
    :name => "Destroy All Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/Associations/CollectionProxy.html#method-i-destroy_all",
    :query => 'User.destroy_all(["id = ? AND admin = \'#{params[:admin]}", params[:id]])',
    :input => {:name => :admin, :example => "') OR 1=1--'"},
    :example => "This example bypasses any conditions and deletes all users.

Because ActiveRecord needs to instantiate each object, this query is performed in a transaction.
The SQL for selecting the records to delete (where the injection occurs) looks like this:

<span class=\"CodeRay\"><span style=\"color:#B06;font-weight:bold\">SELECT</span> <span style=\"background-color:hsla(0,100%,50%,0.05)\"><span style=\"color:#710\">&quot;</span><span style=\"color:#D20\">users</span><span style=\"color:#710\">&quot;</span></span>.* <span style=\"color:#080;font-weight:bold\">FROM</span> <span style=\"background-color:hsla(0,100%,50%,0.05)\"><span style=\"color:#710\">&quot;</span><span style=\"color:#D20\">users</span><span style=\"color:#710\">&quot;</span></span> <span style=\"color:#080;font-weight:bold\">WHERE</span> (id = <span style=\"color:#069\">NULL</span> <span style=\"color:#080;font-weight:bold\">AND</span> admin = <span style=\"background-color:hsla(0,100%,50%,0.05)\"><span style=\"color:#710\">'</span><span style=\"color:#710\">'</span></span>) <span style=\"color:#080;font-weight:bold\">OR</span> <span style=\"color:#00D\">1</span>=<span style=\"color:#00D\">1</span><span style=\"color:#777\">--')</span></span>",
    :desc => <<-MD
Any methods which delete records should be used with lots of caution! `destroy_all` is only slightly safer
than `delete_all` since it will invoke callbacks associated with the model.

The `destroy_all` method takes the same kind of conditions arguments as `find`.
The argument can be a string, an array, or a hash of conditions. Strings will not
be escaped at all. Use an array or hash to safely parameterize arguments.

Never pass user input directly to `destroy_all`.
    MD
  },

  {
    :action => :exists,
    :name => "Exists? Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/FinderMethods.html#method-i-exists-3F",
    :query => 'User.exists? ["name = \'#{params[:user]}\'"]',
    :input => {:name => :user, :example => "') or (SELECT 1 FROM 'orders' WHERE total > 1)--" },
    :example => "This is more obvious than the example above, but demonstrates checking another table for a given value.",
    :desc => <<-MD
The `exists?` method is used to check if a given record exists. The argument is usually a primary key. If the argument is a string, it will be escaped. If the argument is an array or hash, it will be treated like a conditions option.

*However*, code like this is *not safe*:

<pre>
<span class="CodeRay"><span style="color:#036;font-weight:bold">User</span>.exists? params[<span style="color:#A60">:user</span>]</span>
</pre>

Since Rails will automatically convert parameters to arrays or hashes, it is possible to inject any SQL into this query.

For example,

`?user[]=1`

Will generate the query

<pre>
<span class="CodeRay"><span style="color:#B06;font-weight:bold">SELECT</span>  <span style="color:#00D">1</span> <span style="color:#080;font-weight:bold">AS</span> one <span style="color:#080;font-weight:bold">FROM</span> <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">&quot;</span><span style="color:#D20">users</span><span style="color:#710">&quot;</span></span>  <span style="color:#080;font-weight:bold">WHERE</span> (<span style="color:#00D">1</span>) LIMIT <span style="color:#00D">1</span></span>
</pre>

This query will always return true. To be be safe, convert user input to a string or integer if using it as the primary key in `exists?`.
  MD
  },

  {
    :action => :find_by,
    :name => "Find By Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/FinderMethods.html#method-i-find_by",
    :query => 'User.find_by params[:id]',
    :input => {:name => :id, :example => "admin = 't'"},
    :example => 'This will find users who are admins.',
    :desc => <<-MD
Added in Rails 4, the `find_by`/`find_by!` methods are simply calling `where(*args).take`, so all the options for `where` also apply.

Note that `find_or_create_by` / `find_or_create_by!` / `find_or_initialize_by` all call `find_by`
and are therefore vulnerable to SQL injeection in the same way.

The safest (and most common) use of these methods is to pass in a hash table.
    MD
  },

  {
    :action => :from_method,
    :name => "From Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-from",
    :query => "User.from(params[:from])",
    :input => {:name => :from, :example => "users WHERE admin = 't';"},
    :example => "Instead of returning all non-admin users, we return all admin users.",
    :desc => <<-MD
The `from` method accepts arbitrary SQL.
    MD
  },

  {
    :action => :group_method,
    :name => "Group Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/FinderMethods.html#method-i-find",
    :query => "User.where(:admin => false).group(params[:group])",
    :input => {:name => :group, :example => "name UNION SELECT * FROM users"},
    :example => "The intent of this query is to group non-admin users by the specified column. Instead, the query returns all users.",
    :desc => "The `group` method accepts arbitrary SQL strings."
  },

  {
    :action => :having,
    :name => "Having Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-from",
    :query => 'Order.where(:user_id => 1).group(:user_id).having("total > #{params[:total]}")',
    :input => {:name => :total, :example => "1 UNION SELECT * FROM orders"},
    :example => "This input injects a union in order to return all orders, instead of just the orders from a single user.",
    :desc => "The `having` method does not escape its input and is easy to use for SQL injection since it tends to be at the end of a query."
  },


  {
    :action => :joins,
    :name => "Joins Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-joins",
    :query => 'Order.joins(params[:table])',
    :input => {:name => :table, :example => "--"},
    :example => 'Skip WHERE clause and return all orders instead of just the orders for the specified user.',
    :desc => 'The `joins` method can take an array of associations or straight SQL strings.'
  },

  {
    :action => :lock,
    :name => "Lock Method and Option",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-lock",
    :query => "User.where(1).lock(params[:lock])",
    :input => {:name => :lock, :example => "?"},
    :example => "Not a real example: SQLite does not support this option.",
    :desc => <<-MD
The `lock` method and the `:lock` option for `find` and related methods accepts a SQL fragment.
    MD
  },

  {
    :action => :order,
    :name => 'Order Method',
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-order",
    :query => 'User.order("#{params[:sortby]} ASC")',
    :input => {:name => :sortby, :example => "(CASE SUBSTR(password, 1, 1) WHEN 's' THEN 0 else 1 END)"},
    :example => 'Taking advantage of SQL injection in `ORDER BY` clauses is tricky, but a `CASE` statement can be used to test other fields, switching the sort column for true or false. While it can take many queries, an attacker can determine the value of the field.',
    :desc => 'The `order` method accepts any SQL string.'
  },

  {
    :action => :pluck,
    :name => "Pluck Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/Calculations.html#method-i-pluck",
    :query => 'Order.pluck(params[:column])',
    :input => {:name => :column, :example => 'password FROM users--'},
    :example => 'Output the passwords from the users table.',
    :desc => <<-MD
The `pluck` method is intended to select a specific column from a table. Instead, it accepts any SQL statement at all. This allows an attacker to completely control the query from `SELECT` onwards.

However, the return result will still be an array of values from a single column.
    MD
  },

  {
    :action => :reorder,
    :name => "Reorder Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-reorder",
    :query => 'User.order("name DESC").reorder("id #{params[:order]}")',
    :input => {:name => :order, :example => ", 8"},
    :example => 'The `reorder` method is vulnerable to the same type of injection attacks as `order`.',
    :desc => "The `reorder` method is not very common, but it accepts any SQL fragment just like the `order` method."
  },

  {
    :action => :select_method,
    :name => 'Select Method',
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-select",
    :query => 'User.select(params[:column])',
    :input => {:name => :column, :example => "* FROM users WHERE admin = 't' ;"},
    :example => 'Since the `SELECT` clause is at the beginning of the query, nearly any SQL can be injected.',
   :desc => 'The `:select` option allows complete control over the `SELECT` clause of the query.'
  },

  {
    :action => :where,
    :name => "Where Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/QueryMethods.html#method-i-where",
    :query => 'User.where("name = \'#{params[:name]}\' AND password = \'#{params[:password]}\'").first',
    :input => {:name => :name, :example => "') OR 1--"},
    :example => 'The example below is using classic SQL injection to bypass authentication.',
    :desc => <<-MD
The `where` method can be passed a straight SQL string. Calls using a hash of name-value pairs are escaped, and the array form can be used for safely parameterizing queries.
     MD
  },

  {
    :action => :update_all_method,
    :name => "Update All Method",
    :link => "https://api.rubyonrails.org/v4.2.11.1/classes/ActiveRecord/Relation.html#method-i-update_all",
    :query => 'User.update_all("admin = 1 WHERE name LIKE \'%#{params[:name]}%\'")',
    :input => {:name => :name, :example => '\' OR 1=1;'},
    :example => "Update every user to be an admin.",
    :desc => <<-MD
Like `delete_all`, `update_all` accepts any SQL as a string.

User input should never be passed directly to `update_all`, only as values in a hash table.
    MD
  },
]
