class Page < ActiveRecord::Base
    belongs_to :admin
    belongs_to :club, optional: true
    
    has_attached_file :img_one, styles: { original: {convert_options: '-auto-orient'}, medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :img_one, content_type: /\Aimage\/.*\z/
    
    has_attached_file :img_two, styles: { original: {convert_options: '-auto-orient'}, medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :img_two, content_type: /\Aimage\/.*\z/
    
    has_attached_file :img_three, styles: { original: {convert_options: '-auto-orient'}, medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :img_three, content_type: /\Aimage\/.*\z/
    
    validates :title, :content_one, presence: true
    
    has_attached_file :link_pdf_one
    validates_attachment_content_type :link_pdf_one, content_type: "application/pdf"
    
    has_attached_file :link_pdf_two
    validates_attachment_content_type :link_pdf_two, content_type: "application/pdf"
    
    has_attached_file :link_pdf_three
    validates_attachment_content_type :link_pdf_three, content_type: "application/pdf"
    
    def extract_keywords
        if self.site_page === "event" || self.site_page === "news"
            extra = self.site_page === "event" ? "event" : "news"
        else 
            extra = nil
        end
        title_keywords = self.title.split(" ")
        club_keywords = Club.first.club_name.split(" ")
        club_keywords << ["charity", extra]
       return (title_keywords << club_keywords).flatten!
    end
end