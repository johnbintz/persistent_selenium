require "persistent_selenium/version"
require 'selenium-webdriver'

module PersistentSelenium
  class << self
    attr_writer :port, :browser, :timeout, :chrome_extensions

    def port
      @port ||= 9854
    end

    def browser
      @browser ||= :firefox
    end

    def timeout
      @timeout ||= 120
    end

    def chrome_extensions
      @chrome_extensions ||= []
    end

    def url
      "druby://localhost:#{port}"
    end

    def configure
      yield self
    end

    def load_dotfile(file = '.persistent_selenium')
      if File.file?(file)
        load file
      end
    end
  end
end
