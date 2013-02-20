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
        "Syntax Error"
      rescue Exception
        "Unknown exception"
      end
    end

    @result = command.call
    @result = ap @result #Find a way to send data from ap to a string


    render layout: false
  end
end
