class HomeController < ApplicationController
  skip_before_filter :authenticate_recruiter!
  def index
    render layout: false
  end
end
