class ContactMailer < ApplicationMailer
    default from: "gameatelier144@gmail.com"

    def send_mail(email, title, content)
        @email = email
        @title = title
        @content = content
        mail(subject: "『Atelier144』へのお問い合わせ", to: Rails.application.credentials.administrator[:email]) do |format|
            format.text
        end
    end
end
