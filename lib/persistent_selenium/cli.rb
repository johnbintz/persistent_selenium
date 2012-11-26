require 'thor'
require 'persistent_selenium'

module PersistentSelenium
  class CLI < Thor
    desc "start", "Start the server"
    def start
      require 'persistent_selenium/browser'
      require 'drb'

      port = ENV['PORT'] || PersistentSelenium.port
      browser = ENV['BROWSER'] || PersistentSelenium.browser

      puts "Starting persistent_selenium on #{port} with #{browser}"

      browser = Browser.new(browser)
      browser.browser

      DRb.start_service PersistentSelenium.url, browser

      DRb.thread.join
    end
  end
end

