module ApiV0
  class Base < Grape::API
    version 'v0', using: :path
    helpers ::ApiV0::Helpers
    include ApiV0::ExceptionHandlers
    use ApiV0::Auth::Middleware

    mount Courses
    mount Ping
    mount PurchasedCourses
  end
end
