class OrderController < ApplicationController
    def create
        @event = Event.find(params[:id])
        @list_of_order_ids = []

        # Inside params there will be harsh with "ticket_type_id" = "ticket_type_quantity_purchase"
        # Loop through tickets_type and save them to order.

        i = 0 # count input
        j = 0 # count output
        @event.ticket_types.each do |ticket_type|
            @order = Order.new
            @order.event_id = params[:id]
            @order.user_id = current_user.id
            quantity = params[ticket_type.id.to_s].to_i 
            if (quantity > 0)
                @order.ticket_type_id = ticket_type.id 
                @order.quantity = quantity
                i = i + 1

                if @order.save
                    # Capture the id of that order created to render in view
                    @list_of_order_ids.append(@order.id)

                    # Reduce quantity of max_quantity in ticket_type
                    ticket_type.max_quantity = ticket_type.max_quantity - quantity - 1
                    if ticket_type.save
                        j = j + 1
                    else
                        flash[:error] = "Cannot buy more ticket than available"
                    end
                else
                    flash[:error] = "Error when create order with ticket type #{ticket_type.name}"
                end
            end
        end

        if i == j
            @orders = Order.find(@list_of_order_ids)
            flash[:success] = "Order created!"
        else
            flash[:error] = "Ops. Something wrong! Order cannot created"
            redirect_to :back
        end
    end
end
