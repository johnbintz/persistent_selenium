require_relative './driver'

RSpec.configure do |c|
  c.before :each do
    if Capybara.current_driver == :persistent_selenium
      Capybara.server_port ||= '3001'
      Capybara.app_host ||= "http://localhost:#{Capybara.server_port}"
    end
  end
end
