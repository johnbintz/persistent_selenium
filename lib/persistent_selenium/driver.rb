require 'persistent_selenium'
require 'persistent_selenium/browser'
require 'capybara/selenium/driver'

# make sure these classes exist on this end
[ Selenium::WebDriver::Error::StaleElementReferenceError, Selenium::WebDriver::Error::UnhandledError, Selenium::WebDriver::Error::ElementNotVisibleError ]

require 'persistent_selenium/drb'

Capybara.register_driver :persistent_selenium do |app|
  require 'drb'

  service = DRb.start_service
  browser = DRbObject.new nil, PersistentSelenium.url

  server = Capybara::Server.new(app)
  server.boot

  browser.set_app_host(Capybara.app_host)
  browser
end

