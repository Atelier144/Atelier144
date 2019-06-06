class UsersController < ApplicationController
  def show
  end

  def mypage

  end

  def update
    @user = User.find_by(id: params[:id])
    @user.image_name = params[:image]
    if @user.save
      redirect_to("/mypage")
    else
      redirect_to("/")
    end
    
  end

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to("/")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

  def signup_form
    
  end

  def signup
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], is_certificated: true)
    if params[:agreement] == "agree"
      if params[:password] == params[:password2] && params[:password]
        if @user.save
          redirect_to("/")
        else
          @error_message = "ユーザー登録に失敗しました"
        end
      else
        @error_message = "パスワードをもう一度確認してください"
      end
    else
      @error_message = "利用規約に同意してください。"
    end
  end
end
