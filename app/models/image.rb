class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :image_file

  enum access_level: {open: 0, unlisted: 1, secret: 2}, _default: :open
  
  validates :image_file, presence: true
  validates :title, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :access_level, inclusion: { in: access_levels.keys }

  validate :validate_image_file

  before_save :process_tags
  
  private

  def validate_image_file
    if !self.image_file.image?
      errors.add(:image_file, 'uploaded file must be an image')
    end
  end

  def process_tags
    tags = self.tags

    tags_list = []

    unless tags.blank?
        tags.split(',').each do |tag|
          tags_list.push(tag.strip.downcase)
        end

        self.tags = tags_list.uniq.sort.join(',')
    end
  end
end
