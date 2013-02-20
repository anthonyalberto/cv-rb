class Cat < ActiveRecord::Base
  belongs_to :candidate
  has_many :pictures, as: :picturable
  has_many :skills, as: :skillable
  attr_accessible :current_status, :name
end
