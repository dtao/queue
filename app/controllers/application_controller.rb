class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, :with => :handle_validation_error

  helper_method :logged_in?, :current_user

  def alert(message, type=:info)
    flash[:notice] = message
    flash[:notice_type] = type
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user_checked ||= begin
      @current_user = session[:user_id] && User.find(session[:user_id])
      true
    end

    @current_user
  end

  def login_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    session.delete(:user_id)
  end

  protected

  def handle_validation_error(error)
    alert(error.record.errors.full_messages.first, :error)
    redirect_to(root_path)
  end
end
