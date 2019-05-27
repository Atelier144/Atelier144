class InfiniteBlocksController < ApplicationController
  def home
  end

  def records
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
