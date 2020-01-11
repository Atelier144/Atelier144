require "date"

class InfiniteBlocksController < ApplicationController
  before_action :set_twitter_client, only:[:tweet]

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
      flash[:score] = score
      flash[:level] = level
    else
      flash[:notice] = "ランキングの登録に失敗しました"
    end
  end

  def result
    @user = @current_user
    @has_twitter_account = @user.twitter_uid
    @disabled = @has_twitter_account ? "" : "disabled"
    @score = flash[:score].nil? ? "ー" : flash[:score]
    @level = flash[:level].nil? ? "ー" : flash[:level]
    @rank = "#{InfiniteBlocksRecord.find_by(user_id: @user.id).rank}位"
    @yearly_rank = "#{InfiniteBlocksYearlyRecord.where("updated_at >= ?", Date.today.prev_year(1)).find_by(user_id: @user.id).rank}位"
    @monthly_rank = "#{InfiniteBlocksMonthlyRecord.where("updated_at >= ?", Date.today.prev_month(1)).find_by(user_id: @user.id).rank}位"
    @weekly_rank = "#{InfiniteBlocksWeeklyRecord.where("updated_at >= ?", Date.today.prev_day(7)).find_by(user_id: @user.id).rank}位"
    @content = "https://gameatelier144.com/games/infinite-blocks\n『Infinite Blocks』\nスコア：#{@score}\nレベル：#{@level}\n総合ランキング：#{@rank}\n年間ランキング：#{@yearly_rank}\n月間ランキング：#{@monthly_rank}\n週間ランキング：#{@weekly_rank}\n#Atelier144 #InfiniteBlocks"
  end

  def tweet
    @twitter_client.update(params[:content])
    redirect_to("/games/infinite-blocks/result/tweet-done")
  end

  def tweet_done

  end
end