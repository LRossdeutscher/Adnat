class Organisation < ApplicationRecord
    has_many :users, dependent: :nullify

    validates :name, presence: true
    validates :hourly_rate, numericality: { greater_than_or_equal_to: 0 }
end
