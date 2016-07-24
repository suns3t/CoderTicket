class Order < ActiveRecord::Base
    belongs_to :event
    belongs_to :user
    belongs_to :ticket_type

    validates_presence_of :quantity
    validates_presence_of :ticket_type_id
    validate :number_tickets_less_than_10
    validate :number_tickets_less_than_max_quantity

    def number_tickets_less_than_10
        if quantity
            if (quantity > 10)
                errors.add(:quantity, "You cannot purchase more than 10 tickets at a time")
            end
        end
    end

    def number_tickets_less_than_max_quantity
        if ticket_type_id && quantity
            if (TicketType.find(ticket_type_id).max_quantity < quantity)
                errors.add(:quantity, "You cannot purchase more than available tickets")
            end
        end
    end
end
