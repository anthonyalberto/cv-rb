class Skill < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  attr_accessible :level, :name
end
