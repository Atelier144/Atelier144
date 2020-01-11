require "date"

class InfiniteBlocksController < ApplicationController
  def home
    @user_id = @current_user.nil? ? 0 : @current_user.id
  end

  def records
    if params[:type].nil?
      @title = "総合ランキング"
      @records = InfiniteBlocksRecord.all.order(score: :desc).order(level: :desc).order(udpated_at: :desc)
    elsif params[:type] == "yearly"
      @title = "年間ランキング"
      @records = InfiniteBlocksYearlyRecord.where("updated_at >= ?", Date.today.prev_year(1)).order(score: :desc).order(level: :desc).order(udpated_at: :desc)
    elsif params[:type] == "monthly"
      @title = "月間ランキング"
      @records = InfiniteBlocksMonthlyRecord.where("updated_at >= ?", Date.today.prev_month(1)).order(score: :desc).order(level: :desc).order(udpated_at: :desc)
    elsif params[:type] == "weekly"
      @title = "週間ランキング"
      @records = InfiniteBlocksWeeklyRecord.where("updated_at >= ?", Date.today.prev_day(7)).order(score: :desc).order(level: :desc).order(udpated_at: :desc)
    else
      redirect_to("/games/infinite-blocks/record")
    end
  end

  def record
    user_id = params.require(:user_id).to_i
    score = params.require(:score).to_i
    level = params.require(:level).to_i
    
    record = InfiniteBlocksRecord.find_by(user_id: user_id)
    yearly_record = InfiniteBlocksYearlyRecord.find_by(user_id: user_id)
    monthly_record = InfiniteBlocksMonthlyRecord.find_by(user_id: user_id)
    weekly_record = InfiniteBlocksWeeklyRecord.find_by(user_id: user_id)

    if record.nil?
      record = InfiniteBlocksRecord.new(user_id: user_id, score: score, level: level)
    else
      if record.score < score
        record.score = score
        record.level = level
      elsif record.score == score
        if record.level < level
          record.level = level
        elsif record.level == level
          record.touch
        end
      end
    end

    if yearly_record.nil?
      yearly_record = InfiniteBlocksYearlyRecord.new(user_id: user_id, score: score, level: level)
    elsif yearly_record.updated_at < Date.today.prev_year(1)
      yearly_record.score = score
      yearly_record.level = level
    else
      if yearly_record.score < score
        yearly_record.score = score
        yearly_record.level = level
      elsif yearly_record.score == score
        if yearly_record.level < level
          yearly_record.level = level
        elsif yearly_record.level == level
          yearly_record.touch
        end
      end
    end

    if monthly_record.nil?
      monthly_record = InfiniteBlocksMonthlyRecord.new(user_id: user_id, score: score, level: level)
    elsif monthly_record.updated_at < Date.today.prev_month(1)
      monthly_record.score = score
      monthly_record.level = level
    else
      if monthly_record.score < score
        monthly_record.score = score
        monthly_record.level = level
      elsif monthly_record.score == score
        if monthly_record.level < level
          monthly_record.level = level
        elsif monthly_record.level == level
          monthly_record.touch
        end
      end
    end

    if weekly_record.nil?
      weekly_record = InfiniteBlocksWeeklyRecord.new(user_id: user_id, score: score, level: level)
    elsif weekly_record.updated_at < Date.today.prev_day(7)
      weekly_record.score = score
      weekly_record.level = level
    else
      if weekly_record.score < score
        weekly_record.score = score
        weekly_record.level = level
      elsif weekly_record.score == score
        if weekly_record.level < level
          weekly_record.level = level
        elsif weekly_record.level == level
          weekly_record.touch
        end
      end
    end

    if record.save && yearly_record.save && monthly_record.save && weekly_record.save
      redirect_to("/games/infinite-blocks/records")
    else
      flash[:notice] = "ランキングの登録に失敗しました"
      redirect_to("/")
    end
  end


end
