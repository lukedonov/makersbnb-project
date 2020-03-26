# frozen_string_literal: true

require_relative './databases/setup_test_database'

ENV['ENVIRONMENT'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'capybara'
require 'simplecov'
require 'simplecov-console'
require 'capybara/rspec'
require 'rspec'
require 'helpers/feature_web_helpers'
require 'helpers/user_web_helper'
require 'helpers/unit_web_helpers'
require 'bcrypt'

Capybara.app = InnCognito

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console
                                                               ])
SimpleCov.start do
  add_filter 'database_connection_setup.rb'
end

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
    include UserWebHelper
    UserWebHelper.setup
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
