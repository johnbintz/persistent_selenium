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

    def options
      {}
    end

    def visit(path)
      if !path[/^http/]
        path = @app_host + path
      end

      browser.navigate.to(path)
    end

    def set_app_host(host)
      @app_host = host

      browser.navigate.to('about:blank')
    end

    def reset!
      if @browser
        begin
          @browser.manage.delete_all_cookies
        rescue Selenium::WebDriver::Error::UnhandledError => e
          # delete_all_cookies fails when we've previously gone
          # to about:blank, so we rescue this error and do nothing
          # instead.
        end
      end
    end
  end
end

