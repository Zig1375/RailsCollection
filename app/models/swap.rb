class Swap < ApplicationRecord
    enum state: { new: 1, in_work: 2, ready: 3, sent: 4, declined: 5}
    belongs_to :collection

    validates :name, presence: true, length: { maximum: 32 }
    validates :email, presence: true, email: true
end
