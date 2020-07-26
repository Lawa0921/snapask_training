class PurchasedCoursesController < ApplicationController
  def index
    @purchased_courses = current_user.purchased_courses
  end
end
