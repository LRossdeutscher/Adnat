class Shift < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'

    validates :user, presence: true
    validates :start, presence: true
    validates :finish, presence: true
    validates :break_length, numericality: { greater_than_or_equal_to: 0 }
end
