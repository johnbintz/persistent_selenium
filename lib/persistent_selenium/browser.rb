require 'capybara'
require 'capybara/selenium/driver'
require 'base64'

module PersistentSelenium
  class Browser < Capybara::Selenium::Driver
    def initialize(browser_type)
      @browser_type = browser_type
    end

    def browser
      case @browser_type
      when :firefox
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.cache.disk.enable'] = false
        profile['browser.cache.memory.enable'] = false
        profile['browser.cache.offline.enable'] = false
        profile['network.http.use-cache'] = false

        options = { :profile => profile }
      when :chrome
        options = { :switches => %w{--disk-cache-size=1 --media-cache-size=1} }
      end

      @browser ||= Selenium::WebDriver.for(@browser_type, options)
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
      @app_host = host.dup
      load_splash_page
    end

    def load_splash_page
      browser.navigate.to("data:text/html;base64,#{Base64.encode64(starting_page)}")
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

      GC.enable
      GC.start
      GC.disable
    end

    def starting_page
      <<-HTML
<html>
  <head>
    <title>Persistent Selenium -- Starting up...</title>
    <style>
      body {
        background: #444;
      }

      * {
        font-family: Verdana, Helvetica, sans-serif;
      }

      td {
        background: #ccc;
        width: 50%;
        text-align: center;

        border: solid #333 1px;
        border-radius: 5px;
        padding: 10px;
      }
    </style>
  </head>
  <body>
    <table width="100%" height="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <h1>Persistent Selenium</h1>
          <h2>Starting up...</h2>
        </td>
      </tr>
    </table>
  </body>
</html>
      HTML
    end
  end
end

