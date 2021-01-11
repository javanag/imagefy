class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :image_file

  enum access_level: {open: 0, unlisted: 1, secret: 2}
end
