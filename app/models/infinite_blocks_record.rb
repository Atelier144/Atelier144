class InfiniteBlocksRecord < ApplicationRecord
    validates :user_id, presence: true, uniqueness: true
    validates :score, numericality:{greater_than_or_equal_to: 0, less_than: 1000000}
    validates :level, numericality:{greater_than: 0, less_than_or_equal_to: 30}

    def user
        return User.find_by(id: self.user_id)
    end

    def rank
        return nil
    end
end

# user_id
# score
# level
