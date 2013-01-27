# get the driver ready for use
require 'persistent_selenium/driver'

# set it for all tests
# Capybara.default_driver = Capybara.javascript_driver = :persistent_selenium
#
# or, set it via the ENV, with it being the default
# Before do
#   Capybara.default_driver = Capybara.javascript_driver = (ENV['DRIVER'] || 'persistent_selenium').to_sym
# end

