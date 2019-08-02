module ApplicationHelper
    
    def club
        club = Club.first
        if !club.blank?
            return club
        else
            return ''
        end
    end

    def is_super_admin
       current_admin.email === "george.whittingham@phab.org.uk"
    end
    
    def homepage
       homepage = Page.all.where("site_page = ?", "home").first 
    end
    
    def nav_volunteers
         return Page.where("site_page = ? AND published = ?", "volunteer", true).limit(3) 
    end
    
    def nav_about_list
        return Page.where("site_page = ? AND published = ?", "about", true).order(date_of_event: :asc)
    end
    
    def nav_event_list
        return Page.where("site_page = ? AND published = ? AND date_of_event >= ?", "event", true, Date.today).order(date_of_event: :asc).limit(3) 
    end
    
    def nav_news_list
       return Page.where("site_page = ? AND published = ?", "news", true).order(id: :desc).limit(3);
    end
    
    def nav_gallery_list
       return Gallery.where("published = ?", true).order(id: :desc).limit(3);
    end
    
    def handlise(string)
       words = string.split(" ")
       lowercase = []
       words.each_with_index do |word, i|
           lowercase[i] = word.downcase
       end
       return lowercase.join("_")
    end
    
    def recent_posts
       return Page.where("published = ? AND site_page != ? AND site_page != ?", true, "home", "volunteer").order(id: :desc).limit(3) 
    end
    
    def upcoming_events
       return Page.where("site_page = ? AND published = ? AND date_of_event >= ?", "event", true, Date.today).order(date_of_event: :asc).limit(3) 
    end
    
    def club_news
       return Page.where("site_page = ? AND published = ?", "news", true).order(id: :desc).limit(3) 
    end
    
    def news_header
       return "Latest News" 
    end
    
    def events_header
       return "What's On" 
    end
end
