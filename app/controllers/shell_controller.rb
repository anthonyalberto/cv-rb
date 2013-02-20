class ShellController < ApplicationController

  def index
  end

  def update
    command = proc do
      $SAFE = 3
      begin
        eval(params[:code])
      rescue SecurityError => e
        "Gotcha! Hackers gonna hack => #{e.inspect}"
      rescue SyntaxError => e
        "Syntax Error => #{e.inspect}"
      rescue Exception => e
        "Unknown exception => #{e}"
      end
    end

    @result = command.call


    render layout: false
  end
end
