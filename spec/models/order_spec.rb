require 'rails_helper'

RSpec.describe Order, type: :model do

    it "should not has blank quantity" do
        order = Order.new
        order.valid?
        expect(order.errors[:quantity]).to eq ["can't be blank"]
    end

    it "should not has blank ticket_type_id" do
        order = Order.new
        order.quantity = 2
        order.valid?
        expect(order.errors[:ticket_type_id]).to eq ["can't be blank"]
    end

    it "should not order more than 10 tickets" do
        order = Order.new
        order.quantity = 11
        order.valid?
        expect(order.errors[:quantity]).to eq ["You cannot purchase more than 10 tickets at a time"]
    end
    
    it "should not order more than available ticket" do
        order = Order.new
        order.quantity = 10
        ticket_type = TicketType.new
        ticket_type.max_quantity = 9
        ticket_type.name = "ticket VIP"
        ticket_type.price = "50000"
        ticket_type.save
        order.ticket_type_id = ticket_type.id 
        order.valid?

        expect(order.errors[:quantity]).to eq ["You cannot purchase more than available tickets"]
    end


end
