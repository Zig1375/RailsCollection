class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors.add attribute, (options[:message] || "is not an email") unless
            value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    end
end

class Request < ApplicationRecord
    scope :status, -> (status) { where state: status }
    scope :email, -> (email) { where("email like ?", "%#{email}%")}

    enum state: { 'New request': 1, 'In process': 2, Ready: 3, Sent: 4, Finished: 5, Rejected: 6}
    belongs_to :collection
    has_many :items_requests
    has_many :items, :through => :items_requests

    validates :name, presence: true, length: { maximum: 32 }
    validates :email, presence: true, email: true
end
