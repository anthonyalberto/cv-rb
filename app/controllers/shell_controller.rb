class ShellController < ApplicationController
  def index
  end

  def update
    @result = Shell.new(params[:code]).call_eval
    render layout: false
  end
end
