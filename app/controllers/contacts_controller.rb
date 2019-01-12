class ContactsController < ApplicationController

  def new 
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    check = @contact.nolink
    if check
      @contact.request = request
      if @contact.deliver
        flash[:success] = 'Your message sent successfully!'
        redirect_to root_path
      else
        flash[:danger] = 'There was a problem sending your message.'
        redirect_to contact_us_path
      end
    else
      flash[:danger] = 'There was a problem sending your message.'
      redirect_to root_path
    end
  end
end
