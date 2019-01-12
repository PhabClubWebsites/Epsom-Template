class Club < ActiveRecord::Base
  belongs_to :admin, optional: true
  has_many :pages
  
  has_attached_file :club_logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :club_logo, :content_type => /\Aimage\/.*\z/
  
  has_attached_file :bg_image, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :bg_image, content_type: /\Aimage\/.*\z/
  
  has_attached_file :news_banner_img, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :news_banner_img, content_type: /\Aimage\/.*\z/
  
  has_attached_file :gallery_banner_img, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :gallery_banner_img, content_type: /\Aimage\/.*\z/
  
  has_attached_file :events_banner_img, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :events_banner_img, content_type: /\Aimage\/.*\z/
  
  has_attached_file :contact_banner_img, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :events_banner_img, content_type: /\Aimage\/.*\z/
  
  has_attached_file :about_banner_img, styles: { medium: "500x500>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :events_banner_img, content_type: /\Aimage\/.*\z/
  
  has_attached_file :policies_one
  validates_attachment_content_type :policies_one, content_type: "application/pdf"
  
  has_attached_file :policies_two
  validates_attachment_content_type :policies_two, content_type: "application/pdf"
  
  has_attached_file :policies_three
  validates_attachment_content_type :policies_three, content_type: "application/pdf"
  
  has_attached_file :policies_four
  validates_attachment_content_type :policies_four, content_type: "application/pdf"
  
  has_attached_file :policies_five
  validates_attachment_content_type :policies_five, content_type: "application/pdf"
  
  has_attached_file :policies_six
  validates_attachment_content_type :policies_six, content_type: "application/pdf"
  
  
  
  geocoded_by :meeting_address
  after_validation :geocode, if: ->(obj){ obj.meeting_address.present? and obj.meeting_address_changed? }
  
  def split_address
    self.meeting_address.split(",")
  end
  
  def split_post_address
    self.postal_address.split(",")
  end
end