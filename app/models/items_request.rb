class ItemsRequest < ApplicationRecord
    enum state: { new_item: 1, approved: 2, rejected: 3}

    belongs_to :item
    belongs_to :request
end
