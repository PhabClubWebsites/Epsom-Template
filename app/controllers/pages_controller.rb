class PagesController < ApplicationController
   before_action :authenticate_admin!, only: [:edit, :index, :update, :destroy, :new, :create, :event_list, :news_list, :home_list, :about_list, :volunteer_list]
   before_action :set_page, only: [:edit, :update, :show, :destroy, :published]
   layout "admin", only: [:edit, :new, :event_list, :news_list, :home_list, :about_list, :volunteer_list]
   def new_events
     
   end
   
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(page_params)
    @page.admin_id = current_admin.id
    if @page.site_page == "event"
      title = "event"
    elsif @page.site_page == "news"
      title = "news article"
    elsif @page.site_page == "volunteer"
      title = "volunteer"
    elsif @page.site_page == "about"
      title = "about"
    else
      title = "home page"
    end
    if @page.save
      flash[:success] = "Your #{title} has been created!"
      if @page.site_page == "home"
        redirect_to root_path(preview: "true")
      elsif @page.site_page == "volunteer"
        redirect_to about_us_path(volunteer_preview: "true")
      elsif @page.site_page == "about"
        redirect_to about_us_path(about_preview: "true")
      else
        redirect_to page_path(@page)
      end
    else
       flash[:danger] = @page.errors.full_messages.join(", ")
       redirect_to dashboard_path
    end
  end
  
  def edit
  end
  
  def update
    if @page.site_page == "event"
      title = "event"
    elsif @page.site_page == "news"
      title = "news article"
    elsif @page.site_page == "volunteer"
      title = "volunteer"
    elsif @page.site_page == "about"
      title = "about"
    else
      title = "home page"
    end
    if @page.update(page_params)
      flash[:success] = "Your #{title} was succesfully updated!"
      if @page.site_page == "home"
        redirect_to root_path(preview: "true")
      elsif @page.site_page == "volunteer"
        redirect_to about_us_path(volunteer_preview: "true")
      elsif @page.site_page == "about"
        redirect_to about_us_path(about_preview: "true")
      else
        redirect_to page_path(@page)
      end
    else
      flash[:danger] = @page.errors.full_messages.join(", ")
      redirect_to edit_page_path(@page, site_page: @page.site_page)
    end
  end
  
  def destroy
    @page.destroy
    flash[:danger] = "Your article has been deleted."
    redirect_to dashboard_path
  end
  
  def show
    @next_article = Page.where("site_page = ? AND id > ? AND published = ?", @page.site_page, @page.id, true).first
    @prev_article = Page.where("site_page = ? AND id < ? AND published = ?", @page.site_page, @page.id, true).last
    if !@page.content_one.blank?
      set_meta_tags title: "#{@page.title} - #{Club.first.club_name}",
                description: @page.content_one.truncate(120, separator: ' '),
                keywords: @page.extract_keywords
    end
  end
  
  def event_list
    @event_pages = Page.all.where("site_page = ?", "event").reverse;
  end
  
  def news_list
    @news_pages = Page.all.where("site_page = ?", "news").reverse;
  end
  
  def home_list
    @home_pages = Page.all.where("site_page = ?", "home").reverse;
  end
  
  def remove_image
    @page = Page.find(params[:id])
    case params[:item]
      when "img_one"
        @page.img_one = nil
      when "img_two"
        @page.img_two = nil
      when "img_three"
        @page.img_three = nil
      when "pdf_one"
        @page.link_pdf_one = nil
      when "pdf_two"
        @page.link_pdf_two = nil
      when "pdf_three"
        @page.link_pdf_three = nil
    end
    if @page.save
      redirect_to edit_page_path(@page, site_page: @page.site_page)
    end
  end
  
  def published
    if @page.site_page == "event"
      title = "event"
    elsif @page.site_page == "news"
      title = "news article"
    elsif @page.site_page == "volunteer"
      title = "volunteer"
    else
      title = "home page"
    end
    if @page.published == false
      @page.update_attribute(:published, true)
      flash[:success] = "Your #{title} has been published!"
      if @page.site_page == "home"
        redirect_to root_path(preview: "true")
      elsif @page.site_page == "volunteer"
        redirect_to about_us_path
      elsif @page.site_page == "about"
        redirect_to about_us_path
      else
        redirect_to page_path(@page)
      end
    elsif @page.published == true
      @page.update_attribute(:published, false)
      flash[:danger] = "Your #{title} is no longer published."
      if @page.site_page == "home"
        redirect_to root_path
      elsif @page.site_page == "volunteer"
        redirect_to about_us_path
      elsif @page.site_page == "about"
        redirect_to about_us_path
      else
        redirect_to dashboard_path
      end
    end
  end
  
  def home
    @club = Club.all.where("id = ?", 1)
    @home_pages = Page.where("site_page = ? AND published = ?", "home", true).order(id: :asc)
    @all_home_pages = Page.where("site_page = ?", "home").order(id: :asc)
    @contact = Contact.new
    if !@home_pages.blank?
      set_meta_tags title: "Home - #{Club.first.club_name}",
                description: @home_pages.first.content_one.truncate(180, separator: ' '),
                keywords: @home_pages.first.extract_keywords
    end
  end
  
  def about_us
     @about_us = Page.all.where("site_page = ? AND published = ?", "about", true)
     @about_us_preview = Page.all.where("site_page = ?", "about")
     @volunteers = Page.all.where("site_page = ? AND published = ?", "volunteer", true)
     @volunteers_preview = Page.all.where("site_page = ?", "volunteer")
     if !@about_us.blank?
       set_meta_tags title: "About Us - #{Club.first.club_name}",
                description: @about_us.first.content_one.truncate(180, separator: ' '),
                keywords: @about_us.first.extract_keywords
     end
  end
  
  def about_list
     @about_us_list = Page.all.where("site_page = ?", "about")
  end
  
  def volunteer_list
    @volunteers = Page.all.where("site_page = ?", "volunteer").reverse
  end
  
  def news
     @news_pages = Page.where("site_page = ? AND published = ?", "news", true).paginate(:page => params[:page], :per_page => 5).order('id DESC')
     set_meta_tags title: "Latest News - #{Club.first.club_name}",
              description: "#{Club.first.club_name}'s latest news and articles. See what we've been up to this year!",
              keywords: Club.first.club_name.split(" ").concat(["news, latest, articles, events, parties, charity"])
  end
  
  def events
    @event_pages = Page.where("site_page = ? AND published = ? AND date_of_event >= ?", "event", true, Date.today).paginate(:page => params[:page], :per_page => 5).order(date_of_event: :asc)
    @old_event_pages = Page.where("site_page = ? AND published = ? AND date_of_event < ?", "event", true, Date.today).paginate(:page => params[:page], :per_page => 3).order(date_of_event: :asc)
    set_meta_tags title: "What's On - #{Club.first.club_name}",
              description: "#{Club.first.club_name}'s upcoming events and parties. See what we've got planned for #{Time.current.year}!",
              keywords: Club.first.club_name.split(" ").concat(["news, latest, articles, events, parties, charity"])
  end
  
  def contact_us
    @contact = Contact.new
    set_meta_tags title: "Contact Us - #{Club.first.club_name}",
              description: "#{Club.first.club_name}'s club and contact information. Here's where to find us and when we meet!",
              keywords: Club.first.club_name.split(" ").concat(Club.first.split_address)
  end
  
  private
  
  def page_params
    params.require(:page).permit(:title, :date_of_event, :time_of_event, 
                    :content_one, :img_one, :img_one_format, :content_two, 
                    :img_two, :img_two_format, :content_three, :img_three, 
                    :img_three_format, :site_page, :admin_id, :links_position, 
                    :link_text_one, :link_url_one, :link_text_two, :link_url_two, 
                    :link_text_three, :link_url_three, :link_pdf_one, :link_pdf_two, :link_pdf_three)
  end
  
  def set_page
    @page = Page.find(params[:id])
  end
   
end