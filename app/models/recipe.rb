class Recipe < ActiveRecord::Base
  belongs_to :user
validates :name, presence: true, length: {minimum: 5, maximum: 30}
validates :summary, presence: true, length: {minimum: 10, maximum:100}
validates :description, presence: true, length: {minimum: 100, maximum: 500}
mount_uploader :picture, PictureUploader
validate :picture_size

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Should be less than 5MB")
    end

  end
end
