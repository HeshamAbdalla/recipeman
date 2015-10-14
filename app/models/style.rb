class Style < ActiveRecord::Base
  validates :name, presence: true
  has_many :recipe_styles
  has_many :recipes, through: :recipe_styles
end
