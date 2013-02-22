class Hobby < ActiveRecord::Base
  belongs_to :candidate
  attr_accessible :name
end
