class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.new_message.subject
  #
  def new_message(message)
  	@message = message

    mail to: "antieffort@gmail.com"
  end
end
