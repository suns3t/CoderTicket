class EventsController < ApplicationController
    before_action :require_login, except: [:index, :show]
    before_action :only_event_owner, only: [:edit, :update, :destroy]
    

    def index
        @events = Event.published.current_event.search(params[:search]).sort
    end

    def new
        @event = Event.new
        @venues = Venue.all
        @categories = Category.all
    end

    def create
        @event = Event.new(event_params)
        @event.user_id = current_user.id
        # Not yet published
        @event.published_at = nil

        if @event.save
            flash[:success] = "New Event is created!"
            redirect_to new_event_ticket_path(@event.id)
        else
            flash[:error] = "Fail to save event"
            redirect_to :back
        end
    end

    def edit
        @event = Event.find(params[:id])
        @venues = Venue.all
        @categories = Category.all
    end

    def update
        @event = Event.find(params[:id])
        if @event.update(event_params)
            flash[:success] = "Event is updated!"
            redirect_to new_event_ticket_path(@event.id)
        else
            flash[:error] = "Update error!"
            render :edit
        end
    end

    def show
        @event = Event.find(params[:id])
    end

    def publish
        @event = Event.find(params[:id])

        # Check if event has ticket_type yet.
        if @event.ticket_types.empty?
            flash[:error] = "Event has no ticket types"
            redirect_to new_event_ticket_path(@event.id)
        else
            @event.published_at = Time.now
            if @event.save
                flash[:success] = "Event #{@event.name} is published at #{@event.published_at}"
                redirect_to events_path
            else
                flash[:error] = "Publish error!" 
                redirect_to :back
            end
        end        
    end
    def destroy
    end

    private 
    def event_params
        params.require(:event).permit(:name, :starts_at, :ends_at, 
            :hero_image_url, :extended_html_description, :published_at, :venue_id, :category_id)
    end

    def only_event_owner
        @event = Event.find(params[:id])
        unless @event.user_id == current_user.id
            flash[:error] = "You cannot modify event from other people."
            redirect_to events_path
        end
    end
end
