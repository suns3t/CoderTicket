class TicketType < ActiveRecord::Base
    belongs_to :event
    belongs_to :user

    has_many :orders

    validate :max_quantity_below_0

    def max_quantity_below_0
        if max_quantity < 0
            errors.add(:max_quantity, "Cannot set max_quantity less than 0")
        end
    end
end
