module ApiV0
  module Entities
    class User < ApiV0::Entities::Base
      expose :id
      expose :email
      expose :name
    end
  end
end
