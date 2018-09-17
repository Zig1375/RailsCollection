class Collection < ApplicationRecord
    enum product: { labels: 1, stamps: 2 }

    belongs_to :user
    has_many :categories
    has_many :items

    attr_readonly :product, :countImages
    validates :title, presence: true, length: { minimum: 5, maximum: 32 }
    validates :countImages, inclusion: { in: 1..2 }
end
