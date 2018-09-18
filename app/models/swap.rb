class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors.add attribute, (options[:message] || "is not an email") unless
            value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    end
end

class Swap < ApplicationRecord
    enum state: { new_swap: 1, in_work: 2, ready: 3, sent: 4, declined: 5}
    belongs_to :collection
    has_and_belongs_to_many :items

    validates :name, presence: true, length: { maximum: 32 }
    validates :email, presence: true, email: true
end
