class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, 
              with: :record_not_found
  helper_method :current_cart       
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def current_cart
    @cart ||= Cart.from_hash(session[:cart])
  end

  def record_not_found
    render file: 'public/404.html', status: 404, layout: false
  end
end
