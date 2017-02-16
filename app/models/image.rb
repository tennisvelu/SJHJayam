class Image < ApplicationRecord
	has_one :inward
	has_one :outward
	has_one :document
  mount_uploader :image_path, ImageUploader
end
