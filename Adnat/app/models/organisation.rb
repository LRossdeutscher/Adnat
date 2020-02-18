class Organisation < ApplicationRecord
    has_many :users, dependent: :nullify
end
