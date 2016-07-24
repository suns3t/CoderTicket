class VenuesController < ApplicationController
    before_action :require_login

    def index
        @venues = Venue.all
        @venue = Venue.new(user_id: current_user.id)
        @regions = Region.all
    end

    def new
    end

    def create
        @venue = Venue.new(venue_params)
        @venue.user_id = current_user.id

        respond_to do |format|
            if @venue.save!
                format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
                format.js   {}
                format.json { render json: @venue, status: :created, location: @venue }
            else
                format.html { render action: "new" }
                format.json { render json: @venue.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def venue_params
        params.require(:venue).permit(:name, :full_address, :category_id, :user_id)
    end
end