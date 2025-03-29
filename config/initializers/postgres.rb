require "active_record/connection_adapters/postgresql_adapter.rb"

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.datetime_type = :timestamptz
