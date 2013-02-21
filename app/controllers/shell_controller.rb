class ShellController < ApplicationController
  def index
  end

  def update

    ActiveRecord::Base.class_eval do
      alias_method :old_readonly?, :readonly?

      def readonly?
        true
      end
    end

    command = Shell.call_eval(params[:code])



    @result = command


    ActiveRecord::Base.class_eval do
      alias_method :readonly?, :old_readonly?
    end


    render layout: false
  end
end
