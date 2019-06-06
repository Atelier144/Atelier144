class InfiniteBlocksController < ApplicationController
  def home
  end

  def records
    @whole_records = InfiniteBlocksRecord.all.order(score: :desc).order(level: :desc).order(created_at: :desc)
  end

  def record
    @record = InfiniteBlocksRecord.new(
      user_id: params.require(:user_id),
      score: params.require(:score),
      level: params.require(:level)
    )
    if @record.save
      redirect_to("/games/infinite_blocks/records")
    end
  end
end
