module ApiV0
  module Auth
    class Authenticator
      def initialize(request, params)
        @request = request
        @params  = params
      end

      def authenticate!
        check_token!
        find_user_with_token
      end

      def find_user_with_token
        @user = User.find_by!(api_access_token: @params[:access_key])
      end

      def check_token!
        return @params[:access_key] unless find_user_with_token
      end
    end
  end
end
