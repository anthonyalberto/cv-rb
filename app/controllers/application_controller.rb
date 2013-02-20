class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_recruiter!

  def after_sign_in_path_for(recruiter)
    shell_index_url
  end
end
