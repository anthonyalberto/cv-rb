class Shell < ActiveRecord::Base
  belongs_to :recruiter
  attr_accessible :code_buffer
end
