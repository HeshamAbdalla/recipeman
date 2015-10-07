class Recipe < ActiveRecord::Base
  belongs_to :user
validates :name, presence: true, length: {minimum: 5, maximum: 10}
validates :summary, presence: true, length: {minimum: 10, maximum:100}
validates :description, presence: true, length: {minimum: 100, maximum: 500}
end
