class HomeController < ApplicationController
  @@email_regexp = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i

  def top
    @news = News.order(created_at: :desc).limit(5)
  end

  def games

  end

  def apps
    
  end
  def news
    @news = News.order(created_at: :desc)
  end
  def terms
    
  end
  def privacy

  end

  def contact_form
    if @current_user
      @email = @current_user.email
    end
  end

  def contact
    email = params[:email]
    title = params[:title]
    content = params[:content]
    is_genuine = "true"

    if email !~ @@email_regexp
      is_genuine = nil
      flash[:email_warning] = "メールアドレスを入力してください"
    end

    if title == ""
      is_genuine = nil
      flash[:title_warning] = "件名を入力してください"
    else
      flash[:title] = title
    end

    if content == ""
      is_genuine = nil
      flash[:content_warning] = "メッセージ内容を入力してください"
    else
      flash[:content] = content
    end

    if is_genuine
      ContactMailer.send_mail(email, title, content).deliver
      redirect_to("/contact/done")
    else
      redirect_to("/contact")
    end
  end

  def contact_done

  end
end
