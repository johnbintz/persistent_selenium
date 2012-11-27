require 'persistent_selenium'

Capybara.register_driver :persistent_selenium do |app|
  require 'drb'

  DRb.start_service
  browser = DRbObject.new nil, PersistentSelenium.url

  server = Capybara::Server.new(app)
  server.boot

  browser.set_app_host(Capybara.app_host)
  browser
end

