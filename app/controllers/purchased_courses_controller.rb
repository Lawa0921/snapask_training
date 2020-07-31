class PurchasedCoursesController < ApplicationController
  def index
    @purchased_courses = current_user.purchased_courses.unexpired.includes(:course)
  end
end
