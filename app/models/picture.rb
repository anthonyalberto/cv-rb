class Picture < ActiveRecord::Base
  attr_accessible :legend, :picture
  mount_uploader :picture, PictureUploader
end
