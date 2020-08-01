module ApiV0
 module Entities
    class PurchasedCourse < ApiV0::Entities::Base
      expose :course, with: ApiV0::Entities::Course
      expose :price
      expose :currency
      expose :expirt_date, format_with: :iso8601
      expose :created_at, format_with: :iso8601
    end
  end
end
