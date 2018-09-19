class Collection < ApplicationRecord
    enum product: { labels: 1, stamps: 2, coins: 3 }

    belongs_to :user
    has_many :categories
    has_many :items
    has_many :requests

    attr_readonly :product, :countImages
    validates :title, presence: true, length: { minimum: 4, maximum: 32 }
    validates :countImages, inclusion: { in: 1..3 }
end
