class CartsController < ApplicationController
  def add
    course = Course.find(params[:id])
    current_cart.add_course(course)
    session[:cart] = current_cart.to_hash
    current_cart.add_success ? flash[:notice] = t("courses.add_cart_success") : flash[:notice] = t("courses.cart_notice")
    redirect_to root_path
  end

  def show
  end

  def destroy
    session[:cart] = nil
    redirect_to root_path, notice: t("courses.clean_cart")
  end
end