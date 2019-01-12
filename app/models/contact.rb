class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  def nolink
    puts self.message
    if self.message.include?("http") || self.message.include?("www")
      return false
    else
      return true
    end
  end

  def headers
      club = Club.first
    {
      :subject => "Someone has contacted you from #{club.club_name}'s website",
      :to => club.contact_email,
      :from => %("#{name}" <#{email}>)
    }
  end
end