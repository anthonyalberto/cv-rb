class Cat < ActiveRecord::Base
  belongs_to :candidate
  has_many :pictures, as: :owner
  has_many :skills, as: :owner
  attr_accessible :current_status, :name
end
