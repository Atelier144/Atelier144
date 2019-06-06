class SignupMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.signup_mailer.confirm.subject
  #
  def confirm(user)
    @user = user

    mail to: user.email
    mail subject: "Atelier144、ユーザー登録のお知らせ"
  end
end
