class ItemsRequests < ApplicationRecord
    enum state: { new_item: 1, approved: 2, declined: 3}

    belongs_to :item
    belongs_to :request
    validates_presence_of :state
end
