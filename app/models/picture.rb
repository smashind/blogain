class Picture < ActiveRecord::Base
  mount_uploader :imagename, ImagenameUploader
  belongs_to :image, polymorphic: true
end
