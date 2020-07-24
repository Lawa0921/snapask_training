class CartsController < ApplicationController
  def add
    course = Course.find(params[:id])
    current_cart.add_course(course)
    session[:cart] = current_cart.to_hash
    redirect_to root_path, notice: t("courses.add_cart_success")
  end

  def show
  end

  def destroy
    session[:cart] = nil
    redirect_to root_path, notice: t("courses.clean_cart")
  end
end
