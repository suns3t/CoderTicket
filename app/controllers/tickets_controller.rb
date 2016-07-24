class TicketsController < ApplicationController

    def new
        @event = Event.find(params[:event_id])
    end

    def create
        @ticket_type = TicketType.new(ticket_type_params)
        @ticket_type.user_id = current_user.id
        @ticket_type.event_id = params[:event_id]
        respond_to do |format|
            if @ticket_type.save!
                format.html { redirect_to @ticket_type, notice: 'Venue was successfully created.' }
                format.js   {}
                format.json { render json: @ticket_type, status: :created, location: @ticket_type }
            else
                format.html { render action: "new" }
                format.json { render json: @ticket_type.errors, status: :unprocessable_entity }
            end
        end
    end


    private 
    def ticket_type_params
        params.require(:ticket_type).permit(:name, :price, :max_quantity)
    end

end
