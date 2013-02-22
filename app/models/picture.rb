class Picture < ActiveRecord::Base
  attr_accessible :legend, :picture
  belongs_to :owner, polymorphic: true
  mount_uploader :picture, PictureUploader
end
