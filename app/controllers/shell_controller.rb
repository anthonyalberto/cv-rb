class ShellController < ApplicationController
  layout 'shell'
  def index
  end

  def update
    render text: "YES !"
  end
end
