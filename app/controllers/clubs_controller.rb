class ClubsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_club, only: [:edit, :update]
  
  layout "admin"
  
    def new
      @club = Club.new
    end
    
    def create
      @club = Club.new(club_params)
      if @club.save
         flash[:success] = "Your club has been created!"
         redirect_to dashboard_path
      else
         flash[:danger] = @club.errors.full_messages.join(", ")
         render 'new'
      end  
    end
    
    def website_banners
      # puts params[:club_id]
      @club = Club.find(params[:club_id])
    end
    
    def edit
    
    end
    
    def update
      if @club.update(club_params)
        flash[:success] = "Your club information was successfully updated!"
        redirect_to root_path
      else
        flash[:danger] = @club.errors.full_messages.join(", ")
        render 'edit'
      end
    end
    
  def remove_image
    @club = Club.find(params[:id])
    item = nil
    case params[:item]
      when "bg_image"
        @club.bg_image = nil
        item = "image"
      when "events_banner_img"
        @club.events_banner_img = nil
        item = "image"
      when "news_banner_img"
        @club.news_banner_img = nil
        item = "image"
      when "gallery_banner_img"
        @club.gallery_banner_img = nil
        item = "image"
      when "news_banner_img"
        @club.news_banner_img = nil
        item = "image"
      when "about_banner_img"
        @club.about_banner_img = nil
        item = "image"
      when "contact_banner_img"
        @club.contact_banner_img = nil
        item = "image"
      when "club_logo"
        @club.club_logo = nil
        item = "image"
      when "pdf_one"
        @club.policies_one = nil
        item = "pdf"
      when "pdf_two"
        @club.policies_two = nil
        item = "pdf"
      when "pdf_three"
        @club.policies_three = nil
        item = "pdf"
      when "pdf_four"
        @club.policies_four = nil
        item = "pdf"
      when "pdf_five"
        @club.policies_five = nil
        item = "pdf"
      when "pdf_six"
        @club.policies_six = nil
        item = "pdf"
    end
    if @club.save
      flash[:danger] = "Your #{item} has been removed."
      redirect_to website_banners_path(club_id: @club.id)
    end
  end
    
    private
    
    def club_params
       params.require(:club).permit(:club_name, :charity_number, :club_leader, 
                                    :contact_email, :postal_address, :club_logo, 
                                    :bg_image, :news_banner_img, :events_banner_img, 
                                    :gallery_banner_img, :about_banner_img, 
                                    :contact_banner_img, :bg_position, :contact_number, 
                                    :meeting_time, :meeting_address, :facebook_link, 
                                    :twitter_link, :donate_link , :latitude, :longitude,
                                    :policies_one, :policies_two, :policies_three,
                                    :policies_four, :policies_five, :policies_six,
                                    :policies_one_text, :policies_one_link, 
                                    :policies_two_text, :policies_two_link, 
                                    :policies_three_text, :policies_three_link,
                                    :policies_four_text, :policies_four_link, 
                                    :policies_five_text, :policies_five_link,
                                    :policies_six_text, :policies_six_link) 
    end
    
    def set_club
      @club = Club.find(params[:id])
    end
    
end