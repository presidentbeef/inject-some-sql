if not defined? ActiveRecord::ConnectionAdapters::AbstractAdapter
  abort "Need to be able to override AbstractAdapter log"
end

class ActiveRecord::ConnectionAdapters::AbstractAdapter
  alias oldlog log

  def log sql, *args, &block
    $last_sql = sql unless sql.include? 'transaction'
    oldlog sql, *args, &block
  end
end
