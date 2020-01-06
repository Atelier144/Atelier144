class InfiniteBlocksController < ApplicationController
  def home
    @user_id = @current_user.nil? ? 0 : @current_user.id
  end

  def records
    @whole_records = InfiniteBlocksRecord.all.order(score: :desc).order(level: :desc).order(created_at: :desc)
  end

  def yearly_records

  end

  def monthly_records

  end

  def weekly_records

  end

  def record
    user_id = params.require(:user_id).to_i
    score = params.require(:score).to_i
    level = params.require(:level).to_i
    
    record = InfiniteBlocksRecord.new(user_id: user_id, score: score, level: level)

    if record.save
      redirect_to("/games/infinite-blocks/records")
    else
      flash[:notice] = "ランキングの登録に失敗しました"
      redirect_to("/")
    end
  end
end
