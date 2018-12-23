class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }


  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || ((resource.is_a? Admin) ? '/admin' : '/')
  end

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
      when :user, User
        '/'
      when :admin, Admin
        '/admin/login'
      else
        super
    end
  end

end
