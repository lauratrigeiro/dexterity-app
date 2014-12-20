class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_history

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

  private

  def store_history
    session[:history] ||= ""
    if current_user && session[:history] == course_3_url && current_user.scores.last.course == 3
		flash[:success] = "So you may be wondering - is Course 3 broken? The answer is 'no.' 
		Course 3 is an evil experiment of mine meant to test user persistence: 
		how long is the user going to click randomly appearing buttons before giving up? 
		Congratulations for participating you clicked #{current_user.scores.last.time} times! 
		Course 3 records should now appear for you."
	end
    session[:history] = request.url
  end 
end
