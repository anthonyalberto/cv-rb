class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_recruiter!
  (skip_before_filter :authenticate_recruiter!) if Rails.env.test?

  def after_sign_in_path_for(recruiter)
    shell_index_path
  end
  def after_sign_out_path_for(recruiter)
    new_recruiter_session_path
  end
end
