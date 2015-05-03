ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # Disabling fixtures since we're using factory girl
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Devise::TestHelpers
end

reporter_options = { color: true, slow_count: 5 }
#Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(reporter_options)]
