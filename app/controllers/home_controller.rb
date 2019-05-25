class HomeController < ApplicationController
  def top
    @news = News.all
  end

  def games

  end

  def apps

  end
  def news

  end
  def terms
    
  end
  def privacy

  end
  def contact
    if @current_user
      @email = @current_user.email
    end
  end
end
