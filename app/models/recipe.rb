class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :recipe_styles, dependent: :destroy
  has_many :styles, through: :recipe_styles
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

validates :name, presence: true, length: {minimum: 5, maximum: 30}
validates :summary, presence: true, length: {minimum: 10, maximum:100}
validates :description, presence: true, length: {minimum: 100, maximum: 500}
mount_uploader :picture, PictureUploader
validate :picture_size
default_scope -> { order(created_at: :desc)}

  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Should be less than 5MB")
    end
  end

end
