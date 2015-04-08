# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/new_message
  def new_message
    ContactMailer.new_message(Message.new(name: "Mark Wetzel", 
    	email: "mark@markwetzel.com", body: "This is a test!"))
  end

end
