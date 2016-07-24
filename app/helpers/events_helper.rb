module EventsHelper
    def header_background_image_url
        "https://az810058.vo.msecnd.net/site/global/Content/img/home-search-bg-0#{rand(6)}.jpg"
    end

    def is_event_owner(event_id)
        if current_user
            return Event.find(event_id).user_id == current_user.id
        else
            return false
        end
    end

    def is_not_published(event_id)
        if Event.find(event_id).published_at
            return false
        else
            return true
        end
    end
end
