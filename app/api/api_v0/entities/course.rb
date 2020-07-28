module ApiV0
  module Entities
    class Course < Entities::Base
      expose :id
      expose :name
      expose :type_of_course
      expose :public
      expose :url
      expose :description
      expose :price
      expose :currency
      expose :user_id
      expose :created_at, format_with: :iso8601
    end
  end
end
