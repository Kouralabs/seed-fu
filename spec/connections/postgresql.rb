# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV.fetch('POSTGRES_DB', 'seed_fu_test'),
  host: ENV.fetch('POSTGRES_HOST', 'localhost'),
  username: ENV.fetch('POSTGRES_USER', 'postgres'),
  password: ENV.fetch('POSTGRES_PASS', 'postgres'),
  port: ENV.fetch('POSTGRES_PORT', 5432)
)
