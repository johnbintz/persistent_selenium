require 'thor'
require 'persistent_selenium'

module PersistentSelenium
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../../../skel', __FILE__)
    end

    desc "start", "Start the server"
    method_options :port => PersistentSelenium.port,
      :browser => PersistentSelenium.browser,
      :timeout => PersistentSelenium.timeout
    method_option :chrome_extensions, :type => :array, :default => []
    def start
      require 'persistent_selenium/browser'
      require 'persistent_selenium/drb'

      PersistentSelenium.configure do |c|
        c.port = options[:port]
        c.browser = options[:browser] if options[:browser]
        c.timeout = options[:timeout]
        c.chrome_extensions = options[:chrome_extensions] if !options[:chrome_extensions].empty?
      end

      puts "Starting persistent_selenium on #{PersistentSelenium.port} with #{PersistentSelenium.browser}"

      @browser = Browser.new(PersistentSelenium.browser)
      @browser.browser

      DRb.start_service PersistentSelenium.url, @browser

      trap('TERM') { exit }
      trap('INT') { exit }

      DRb.thread.join
    end

    desc "install", "Install Cucumber hook for using persistent selenium"
    def install
      directory '.', '.'
    end

    default_task :start
  end
end

