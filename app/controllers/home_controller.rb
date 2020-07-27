class HomeController < ApplicationController
  def index
    if current_user.present? 
      @available_for_purchase_courses = Course.open_public.not_owner(current_user)
    else
      @available_for_purchase_courses = Course.open_public
    end
  end
end
