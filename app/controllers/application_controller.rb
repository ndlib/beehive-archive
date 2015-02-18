class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_location
  before_action :redirect_to_sign_in, unless: :user_signed_in?

  protected
    def store_location
      # store last url - this is needed for post-login redirect to whatever the user last visited.
      return unless request.get?
      if (!is_user_path? && !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
    end

    def is_user_path?
      match = request.path =~ /^\/users\/.*/
      match.present?
    end

    def after_sign_in_path_for(resource_or_scope)
      if session["#{resource_or_scope}_return_to"]
        session["#{resource_or_scope}_return_to"]
      else
        session[:previous_url] || root_path
      end
    end

    def redirect_to_sign_in
      redirect_to new_user_session_path
    end

end
