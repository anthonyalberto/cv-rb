class Candidate < ActiveRecord::Base
  attr_accessible :current_status, :email, :name, :phone
  has_many :pictures, as: :owner
  has_many :skills, as: :owner
  [:educations, :open_source_projects, :experiences, :hobbies, :profile_links, :funny_links, :cats].each do |s|
    has_many s
  end

  def cv
    decorate.cv
  end
end
