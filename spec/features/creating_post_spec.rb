require "rails_helper"
require "jwt"

RSpec.describe API::V1::PostsController, type: :routing do
  it { expect(post:    "/authenticate").to   route_to("authentication#authenticate") }

end


