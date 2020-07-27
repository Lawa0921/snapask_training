class CartsController < ApplicationController
  def add
    course = Course.find(params[:id])
    if PurchasedCourse.check_course_expirt_date?(course, current_user)
      flash[:notice] = t("courses.check_expirt_date")
    else
      current_cart.add_course(course)
      session[:cart] = current_cart.to_hash
      current_cart.add_success ? flash[:notice] = t("courses.add_cart_success") : flash[:notice] = t("courses.cart_notice")
    end
    redirect_to root_path
  end

  def show
  end

  def destroy
    session[:cart] = nil
    redirect_to root_path, notice: t("courses.clean_cart")
  end

  def create
    current_cart.courses.each do |course|
      PurchasedCourse.create(user_id: current_user.id, course_id: course.id, expirt_date: (DateTime.now + course.valididy_period.days))
    end
    session[:cart] = nil
    redirect_to root_path, notice: t("courses.purchased_course_notice")
  end
end
