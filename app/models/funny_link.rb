class FunnyLink < ActiveRecord::Base
  belongs_to :candidate
  attr_accessible :name, :url
end
