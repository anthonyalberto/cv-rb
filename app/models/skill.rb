class Skill < ActiveRecord::Base
  belongs_to :skillable, polymorphic: true
  attr_accessible :level, :name
end
