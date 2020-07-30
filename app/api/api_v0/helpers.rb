module ApiV0
  module Helpers
    def authenticate!
      current_user or raise AuthorizationError
    end

    def current_user
      @current_user ||= @env["api_v0.user"]
    end

    def select_course_type(records, param)
      records.select {|record| record.course.type_of_course == param }
    end

    def select_unexpired_course(records)
      records.where("expirt_date > ?", DateTime.now)
    end

    def set_purchased_courses(records, params)
      records = select_course_type(records, params[:type_of_course]) if params[:type_of_course].present?
      records = select_unexpired_course(records) if params[:unexpired]
      return records
    end

  end
end
