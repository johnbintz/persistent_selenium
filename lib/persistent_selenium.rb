require "persistent_selenium/version"
require 'selenium-webdriver'

module PersistentSelenium
  class << self
    attr_writer :port, :browser, :timeout

    def port
      @port ||= 9854
    end

    def browser
      @browser ||= :firefox
    end

    def timeout
      @timeout ||= 120
    end

    def url
      "druby://localhost:#{port}"
    end

    def configure
      yield self
    end
  end
end
