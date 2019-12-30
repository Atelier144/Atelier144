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
    
    @record = InfiniteBlocksRecord.find_or_initialize_by(user_id: user_id)
    if @record.score.nil?
      @record.score = 0
    end
    if @record.level.nil?
      @record.level = 1
    end

    if @record.score < score
      @record.score = score
      @record.level = level
    elsif @record.score == score && @record.level < level
      @record.level = level
    end

    if @record.save
      redirect_to("/games/infinite_blocks/records")
    else
      flash[:notice] = "ランキングの登録に失敗しました"
      redirect_to("/")
    end
  end
end
