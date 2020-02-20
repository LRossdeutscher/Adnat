class User < ApplicationRecord
    belongs_to :organisation, optional: true
    has_many :shifts, dependent: :delete_all, inverse_of: :user

    has_secure_password

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email_address
    validates_uniqueness_of :email_address
    validates :password, length: { minimum: 6 }, :on => :create
    validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, presence: true
end
