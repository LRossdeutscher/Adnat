class Shift < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'

    validates :user, presence: true
    validates :start, presence: true
    validates :finish, presence: true
    # break_length shouldn't be longer than the shift length either.
    # for simplicity, going to assume a maximum break length of 60 minutes
    validates_inclusion_of :break_length, :in => 0..60, :message => "must be between 0 and 60 minutes"
end
