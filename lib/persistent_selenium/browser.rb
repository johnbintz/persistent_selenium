require 'capybara'
require 'capybara/selenium/driver'

module PersistentSelenium
  class Browser < Capybara::Selenium::Driver
    def initialize(browser_type)
      @browser_type = browser_type
    end

    def browser
      @browser ||= Selenium::WebDriver.for(@browser_type)
    end

    def visit(path)
      if !path[/^http/]
        path = @app_host + path
      end

      browser.navigate.to(path)
    end

    def set_app_host(host)
      @app_host = host
    end
  end
end

