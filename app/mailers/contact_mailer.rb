class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send.subject
  #
  def send(email, title, content)
    @greeting = "Hi"

    mail to: "mabuchiakio@gmail.com"
    mail from: email
    mail subject: content
  end
end
