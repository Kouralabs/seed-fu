# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'seed_fu_test',
  username: 'postgres',
  password: 'postgres'
)
