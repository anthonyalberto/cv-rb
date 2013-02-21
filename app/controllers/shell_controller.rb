class ShellController < ApplicationController
  def index
  end

  def update
    @result = Shell.call_eval(params[:code])
    render layout: false
  end
end
