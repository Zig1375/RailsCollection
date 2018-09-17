class Category < ApplicationRecord
  belongs_to :collection
  has_and_belongs_to_many :items

  validates :title, presence: true, length: {maximum: 32 }
end
