module ApiV0
  module Entities
    class PurchasedCourse < Entities::Base
      expose :id
      expose :expirt_date, format_with: :iso8601
      expose :created_at, format_with: :iso8601
    end
  end
end
