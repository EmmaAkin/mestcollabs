#Helper function that tell the RSpec to apply this modul
#for only test that are scoped to our API

module ApiHelper
    include Rack::Test::Methods
        def app
            Rails.application
        end
end