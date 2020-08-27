# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'seed-fu'
require 'logger'

SeedFu.quiet = true

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/../debug.log')

ENV['DB'] ||= 'sqlite3'
puts "Using #{ENV['DB']} to run the tests."
require File.dirname(__FILE__) + "/connections/#{ENV['DB']}.rb"

ActiveRecord::Schema.define version: 0 do
  create_table :seeded_models, force: true do |t|
    t.column :login, :string
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :title, :string
  end

  create_table :seeded_model_no_primary_keys, id: false, force: true do |t|
    t.column :id, :string
  end

  create_table :seeded_model_no_sequences, id: false, force: true do |t|
    t.column :id, :string
  end

  execute('ALTER TABLE seeded_model_no_sequences ADD PRIMARY KEY (id)') if ENV['DB'] == 'postgresql'
end

class SeededModel < ActiveRecord::Base
  validates_presence_of :title
  attr_protected :first_name if respond_to?(:protected_attributes)
  attr_accessor :fail_to_save

  before_save do
    # Older versions of Rails allowed ActiveRecord callbacks to
    # fail based on the return value. Official documentation states
    # that this was changed in 5.0.0,
    # https://apidock.com/rails/v5.0.0.1/ActiveRecord/Callbacks. But
    # there's a bug in the documentation, this didn't happen before 5.1.0.
    # Unless there was some minor release in between which introduced this.
    last_supports_return_version = Gem::Version.new('5.0.0')

    if ActiveRecord.version > last_supports_return_version
      raise ActiveRecord::RecordNotSaved, ':fail_to_save' if fail_to_save
    end

    false if fail_to_save
  end
end

class SeededModelNoPrimaryKey < ActiveRecord::Base
end

class SeededModelNoSequence < ActiveRecord::Base
end

RSpec.configure do |config|
  config.before do
    SeededModel.delete_all
  end
end
