if defined? ActiveRecord::ConnectionAdapters::AbstractAdapter
  $stderr.puts "uep"

  class ActiveRecord::ConnectionAdapters::AbstractAdapter
    alias oldlog log

    def log sql, *args, &block
      $last_sql = sql
      oldlog sql, *args, &block
    end
  end
end
