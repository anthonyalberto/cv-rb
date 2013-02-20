class ShellController < ApplicationController

  def index
  end

  def update
    command = proc do
      $SAFE = 3
      begin
        eval(params[:code])
      rescue SecurityError => e
        "Hackerz gonna hack #{e.inspect}"
      rescue SyntaxError
        "Syntax Error #{e.inspect}"
      rescue Exception
        "Unknown exception"
      end
    end

    @result = command.call


    render layout: false
  end
end
