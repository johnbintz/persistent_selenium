require 'persistent_selenium'
require 'capybara/selenium/driver'

# make sure these classes exist on this end
[ Selenium::WebDriver::Error::StaleElementReferenceError, Selenium::WebDriver::Error::UnhandledError, Selenium::WebDriver::Error::ElementNotVisibleError ]

Before do
  if Capybara.current_driver == :persistent_selenium
    Capybara.server_port ||= '3001'
    Capybara.app_host ||= "http://localhost:#{Capybara.server_port}"
  end
end

require 'persistent_selenium/drb'

Capybara.register_driver :persistent_selenium do |app|
  service = DRb.start_service
  browser = DRbObject.new nil, PersistentSelenium.url

  server = Capybara::Server.new(app)
  server.boot

  browser.set_app_host(Capybara.app_host)
  browser
end

