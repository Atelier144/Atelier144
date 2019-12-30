class NewPasswordMailer < ApplicationMailer
    default from: "gameatelier144@gmail.com"

    def send_mail(user)
        @user = user
        mail(subject: "パスワード再設定", to: @user.email) do |format|
            format.text
        end
    end
end
