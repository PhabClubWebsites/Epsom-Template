class AdminsController < ApplicationController
   before_action :authenticate_admin!
   before_action :is_super_admin, only: [:delete_admin]
   
   layout "admin"
   
   def delete_admin
     admin = Admin.find(params[:id])
     admin.destroy
     if admin.destroyed?
       flash[:success] = "The admin user was successfully removed!"
     else
       flash[:danger] = "There was a problem removing this admin user."
     end
     redirect_to admins_path
   end
   
   def dashboard
     @homepage = Page.all.where("site_page = ?", "home").first
      if !@homepage.blank?
       return @homepage
      else
        return false
      end
   end
    
  def index
    @admin_users = Admin.all
  end
  
  private
  
  def is_super_admin
    is_super = current_admin.email === "george.whittingham@phab.org.uk"
    if !is_super
      flash[:danger] = "You do not have permission to perform this action."
      redirect_to root_path
    end
  end
end