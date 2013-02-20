class Experience < ActiveRecord::Base
  belongs_to :candidate
  attr_accessible :date_from, :date_to, :description, :name, :url
end
