module ApiV0
  module Helpers

    def authenticate!
      current_user or raise AuthorizationError
    end

    def current_user
      @current_user ||= @env["api_v0.user"]
    end

    def permitted_params
      @permitted_params ||= declared(params, include_missing: false, include_parent_namespaces: false)
    end
  end
end
