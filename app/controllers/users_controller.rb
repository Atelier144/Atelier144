class UsersController < ApplicationController
  @@email_regexp = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
  @@url_regexp = Regexp.new(%r{^(http|https)://})

  before_action :forbid_login_user, only:[:login, :login_form, :signup, :signup_form]
  before_action :authenticate_user, only:[:profile_form, :password_form, :email_form, :social_form, :records_form]

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:notice] = "そのアカウントは存在しません"
      redirect_to("/")
    end
    @infinite_blocks_record = InfiniteBlocksRecord.find_by(user_id: @user.id)
    @infinite_blocks_yearly_record = InfiniteBlocksRecord.find_by(user_id: @user.id)
    @infinite_blocks_monthly_record = InfiniteBlocksRecord.find_by(user_id: @user.id)
    @infinite_blocks_weekly_record = InfiniteBlocksRecord.find_by(user_id: @user.id)
  end

  def profile_form
  end

  def password_form
  end

  def email_form
  end
  
  def social_form
  end

  def records_form
    @infinite_blocks_record = InfiniteBlocksRecord.find_by(user_id: @current_user.id)
    @infinite_blocks_yearly_record = InfiniteBlocksRecord.find_by(user_id: @current_user.id)
    @infinite_blocks_monthly_record = InfiniteBlocksRecord.find_by(user_id: @current_user.id)
    @infinite_blocks_weekly_record = InfiniteBlocksRecord.find_by(user_id: @current_user.id)
  end

  def profile_done

  end

  def password_done

  end

  def email_done

  end

  def create_email_done

  end

  def social_done
    @message = nil
    @message = "Twitterアカウントと連携しました。" if params[:code] == "connect-twitter"
    @message = "Twitter連携を解除しました。" if params[:code] == "disconnect-twitter"

  end

  def records_done

  end

  def update_profile
    user = @current_user
    username = params[:username]
    introduction = params[:introduction]
    website = params[:website]

    is_published_profile = params[:is_published_profile] == "on"
    is_published_introduction = params[:is_published_introduction] == "on"
    is_published_url = params[:is_published_url] == "on"
    is_published_twitter_url = params[:is_published_twitter_url] == "on"
    is_published_records = params[:is_published_records] == "on"

    is_genuine = "true"

    if username == ""
      is_genuine = nil
      flash[:username_warning] = "ユーザー名を入力してください"
    elsif User.where.not(id: user.id).find_by(name: username)
      is_genuine = nil
      flash[:username] = ""
      flash[:username_warning] = "そのユーザー名は既に使用されています"
    else
      flash[:username] = username
    end

    if introduction.length > 300
      is_genuine = nil
      flash[:introduction] = ""
      flash[:introduction_warning] = "300字以内で記述してください"
    else
      flash[:introduction] = introduction
    end

    if website !~ @@url_regexp && website != ""
      is_genuine = nil
      flash[:website] = ""
      flash[:website_warning] = "そのアドレスは無効です"
    else
      flash[:website] = website
    end
    
    flash[:is_published_profile] = is_published_profile
    flash[:is_published_introduction] = is_published_introduction
    flash[:is_published_url] = is_published_url
    flash[:is_published_twitter_url] = is_published_twitter_url
    flash[:is_published_records] = is_published_records

    if is_genuine
      if params[:is_default]
        user.remove_image_name!
      elsif params[:image].present?
        user.image_name = params[:image]
      end
      user.name = username
      user.introduction = introduction
      user.web_site = website == "" ? nil : website

      user.is_published_profile = is_published_profile
      user.is_published_introduction = is_published_introduction
      user.is_published_url = is_published_url
      user.is_published_twitter_url = is_published_twitter_url
      user.is_published_records = is_published_records

      if user.save
        redirect_to("/settings/profile/done")
      else
        flash[:notice] = "プロフィールの更新に失敗しました"
        redirect_to("/settings/profile")
      end
    else
      redirect_to("/settings/profile")
    end
  end

  def update_password
  end

  def update_email
    user = @current_user
    current_email = params[:current_email]
    new_email = params[:new_email]

    is_genuine = "true"
    if current_email != user.email
      is_genuine = nil
      flash[:current_email_warning] = "メールアドレスが間違っています"
    else
      flash[:current_email] = current_email
    end

    if new_email !~ @@email_regexp
      is_genuine = nil
      flash[:new_email_warning] = "メールアドレスを入力してください"
    elsif User.where.not(id: user.id).find_by(email: new_email)
      is_genuine = nil
      flash[:new_email_warning] = "そのメールアドレスは既に利用されています"
    else
      flash[:new_email]
    end

    if is_genuine
      user.email = new_email
      if user.save
        redirect_to("/settings/email")
      else
        flash[:notice] = "メールアドレスの更新に失敗しました"
        redirect_to("/settings/email")
      end
    else
      redirect_to("/settings/email")
    end
  end

  def create_email #パスワードもだよ！
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    is_genuine = "true"
    if email !~ @@email_regexp
      is_genuine = nil
      flash[:create_email_email_warning] = "メールアドレスを入力してください"
    elsif User.find_by(email: email)
      is_genuine = nil
      flash[:create_email_email_warning] = "そのメールアドレスは既に利用されています"
    else
      flash[:create_email_email] = email
    end

    if password.length < 8 || password.length > 32
      is_genuine = nil
      flash[:create_email_password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:create_email_password] = password
    end

    if password != password_confirmation
      is_genuine = nil
      flash[:create_email_password_confirmation_warning] = "もう一度入力してください"
    else
      flash[:create_email_password_confirmation] = password_confirmation
    end

    if is_genuine
      user = User.find_by(id: @current_user.id)
      user.email = email
      user.password = password
      user.password_confirmation = password_confirmation
      if user.save
        redirect_to("/settings/email")
      else
        flash[:notice] = "メールアドレスおよびパスワードの登録に失敗しました"
        redirect_to("/settings/email")
      end
    else
      redirect_to("/settings/email")
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
    @username = params[:username]
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]

    is_genuine = "true"
    if @username == ""
      is_genuine = nil
      flash[:signup_username_warning] = "ユーザー名を入力してください"
    elsif User.find_by(name: @username)
      is_genuine = nil
      flash[:signup_username_warning] = "そのユーザー名は既に存在します"
    else
      flash[:signup_username] = @username
    end

    if @@email_regexp !~ @email
      is_genuine = nil
      flash[:signup_email_warning] = "メールアドレスを入力してください"
    elsif User.find_by(email: @email)
      is_genuine = nil
      flash[:signup_email_warning] = "そのメールアドレスは既に使用されています"
    else
      flash[:signup_email] = @email
    end

    if @password.length < 8 || @password.length > 32
      is_genuine = nil
      flash[:signup_password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:signup_password] = @password
    end

    if @password != @password_confirmation
      is_genuine = nil
      flash[:signup_password_confirmation_warning] = "もう一度入力してください"
    else
      flash[:signup_password_confirmation] = @password_confirmation
    end

    if is_genuine == "true"
      new_user = User.new(name: @username, email: @email, password: @password, password_confirmation: @password_confirmation)
      if new_user.save
        user_id = User.find_by(email: @email).id
        session[:user_id] = user_id;
        redirect_to("/")
      else
        flash[:notice] = "ユーザー登録に失敗しました"
        redirect_to("/signup")
      end
    else
      redirect_to("/signup")
    end
  end

  def signup_username_confirmation
    user = User.find_by(name: params[:username])
    render json: user
  end

  def signup_email_confirmation
    user = User.find_by(email: params[:email])
    render json: user
  end

  def forgot_password_form

  end

  def forgot_password
    user = User.find_by(email: params[:email])
    hash = ""
    if user
      loop do
        hash = generate_random_code(16)
        break if User.find_by(new_password_hash: hash).nil?
      end
      user.new_password_hash = hash
      if user.save
        NewPasswordMailer.send_mail(user).deliver
        redirect_to("/login/forgot_password/certificated")
      else
        redirect_to("/login/forgot_password")
      end
    else
      redirect_to("/login/forgot_password")
    end
  end

  def certificated_forgot_password

  end



  def new_password_form
    user = User.find_by(new_password_hash: params[:hash])
    if user.nil?
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  def new_password
    user = User.find_by(new_password_hash: params[:hash])
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    is_genuine = "true"

    if user
      if password.length < 8 || password.length > 32
        is_genuine = nil
        flash[:password_warning] = "8字以上、32字以下のパスワードを入力してください"
      else
        flash[:password] = password
      end

      if password != password_confirmation
        is_genuine = nil
        flash[:password_confirmation_warning] = "もう一度入力してください"
      else
        flash[:password_confirmation] = password_confirmation
      end

      if is_genuine
        user.password = password
        user.password_confirmation = password_confirmation
        user.new_password_hash = nil
        if user.save
          session[:user_id] = user.id
          redirect_to("/")
        else
          flash[:notice] = "パスワードの再設定に失敗しました"
          redirect_to("/")
        end
      else
        redirect_to("/new_password/#{params[:hash]}")
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  def twitter
    begin
      auth_hash = request.env["omniauth.auth"]
      @provider = auth_hash[:provider]
      @uid = auth_hash[:uid]
      @name = auth_hash[:info][:name]
      @image = auth_hash[:info][:image]
      @introduction = auth_hash[:info][:description]
      @website = auth_hash[:info][:urls][:Website]
      @twitter_url = auth_hash[:info][:urls][:Twitter]
    rescue => exception
      puts exception
      redirect_to("/")
    end

  end

  def facebook
  end

  def twitter_post
    if params[:provider] == "twitter"
      found_user = User.find_by(twitter_uid: params[:uid])
      if found_user
        if session[:user_id]
          puts "Twitter Connection Error"
          flash[:twitter_connection_error] = "そのTwitterアカウントは既に利用されています"
          redirect_to("/settings/social")
        else
          puts "Twitter Login"
          session[:user_id] = found_user.id
          redirect_to("/")
        end
      else
        if session[:user_id]
          puts "Twitter Connection"
          user = User.find_by(id: session[:user_id])
          user.twitter_uid = params[:uid]
          user.twitter_url = params[:twitter_url]
          if user.save
            redirect_to("/settings/social/done/connect-twitter")
          else
            flash[:notice] = "Twitterとの連携に失敗しました"
            redirect_to("/settings/social")
          end
        else
          puts "Twitter Signup"
          password = generate_random_code(30)
          new_user = User.new(name: params[:name], twitter_uid: params[:uid], password: password)
          if new_user.save
            session[:user_id] = User.find_by(twitter_uid: params[:uid]).id
            redirect_to("/")
          else
            puts "TWITTER SIGNUP FAILED"
            redirect_to("/")
          end
        end
      end
    else
      redirect_to("/")
    end
  end

  def facebook_post
  end

  def social_failure
    if session[:user_id]
      flash[:notice] = "SNS連携に失敗しました"
      redirect_to("/settings/social")
    else
      flash[:notice] = "ログインおよび新規登録に失敗しました"
      redirect_to("/")
    end
  end

  def disconnect_twitter
    user = @current_user
    if user.email
      user.twitter_uid = nil
      user.twitter_url = nil
      if user.save
        redirect_to("/settings/social/done/disconnect-twitter")
      else
        flash[:notice] = " Twitter連携解除に失敗しました"
        redirect_to("/settings/social")
      end
    else
      flash[:notice] = "メールアドレスが登録されていません"
      redirect_to("/settings/social")
    end
  end

  def disconnect_facebook

  end

  private

  def generate_random_code(num)
    retval = ""
    for i in 1..num
      code = rand(36).to_s(36)
      retval += code
    end
    return retval
  end
  
end
