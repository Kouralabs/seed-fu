# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  database: ENV.fetch('MYSQL_DATABASE', 'seed_fu_test'),
  host: ENV.fetch('MYSQL_HOST', '127.0.0.1'),
  username: ENV.fetch('MYSQL_USER', 'postgres'),
  password: ENV.fetch('MYSQL_PASSWORD', 'postgres'),
  port: ENV.fetch('MYSQL_PORT', 3306)
)
