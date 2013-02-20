class OpenSourceProject < ActiveRecord::Base
  belongs_to :candidate
  attr_accessible :description, :name, :url
end
