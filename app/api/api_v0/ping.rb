module ApiV0
  class Ping < Grape::API
    before { authenticate! }
    desc 'Ping pong'
    get "/ping" do
      "success"
    end
  end
end
