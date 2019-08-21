require "simplecov"

SimpleCov.start "rails" do
  add_filter "/workarea/listrak/version.rb"
  add_filter %r{lib/workarea/listrak/bogus*}
  add_group "View Models", "app/view_models"
  add_group "Queries", "app/queries"
  add_group "Email Api", %r{app.*email_api}
  add_group "Data Api", %r{app.*data_api}
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
require "rails/test_help"
require "workarea/test_help"
