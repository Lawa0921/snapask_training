module ApiV0
  module Helpers
    def authenticate!
      current_user or raise AuthorizationError
    end

    def current_user
      @current_user ||= @env["api_v0.user"]
    end

    def set_purchased_courses(records, params)
      records = records.select_unexpired_course if params[:unexpired]
      records = records.select_course_type(params[:type_of_course]) if params[:type_of_course].present?
      return records
    end

  end
end
