class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_user!
    unless current_user
        render 'signin.js'
    end
  end

  def is_custom_tag(tagVal)
    if tagVal.length == 0
        return false
    end
    if tagVal.length == 36
        if tagVal =~ /.{8}\-.{4}\-.{4}\-.{4}\-.{12}/
            return false
        end
    end
    return true
  end
end
