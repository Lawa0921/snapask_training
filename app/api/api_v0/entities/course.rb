module ApiV0
  module Entities
    class Course < ApiV0::Entities::Base
      expose :id
      expose :name
      expose :type_of_course
      expose :public
      expose :url
      expose :description
      expose :price
      expose :currency
    end
  end
end
