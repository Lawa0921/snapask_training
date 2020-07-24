class HomeController < ApplicationController
  def index
    @available_for_purchase_courses = Course.open_public
  end
end
