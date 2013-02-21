class ShellController < ApplicationController
  def index
  end

  def update
    @shell = Shell.new(params[:code])
    @result = @shell.call_eval
    render format: :json
  end
end
