class Item < ApplicationRecord
    paginates_per 50
    mount_uploaders :images, ImageUploader
    serialize :images, JSON # If you use SQLite, add this line.
    attr_readonly :images

    belongs_to :collection
    has_and_belongs_to_many :categories
    has_and_belongs_to_many :requests


    validates :title, presence: false, length: { maximum: 32 }
    validates :note, presence: false, length: { maximum: 32 }

    validates :images, length: {
        minimum: :countImages,
        maximum: :countImages,
        message: 'are required'
    }

    def countImages
        collection.countImages
    end
end