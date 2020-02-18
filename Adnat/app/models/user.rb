class User < ApplicationRecord
    belongs_to :organisation, optional: true
    has_many :shifts, dependent: :delete_all

    has_secure_password

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email_address
    validates_uniqueness_of :email_address
    validates :password, length: { minimum: 6 }, :on => :create

    # Set password requirements using AJAX
    #PASSWORD_REQUIREMENTS = /\A
    #(?=.{6,}) # Require at least 6 characters
    #/x
    #validates :password, format: PASSWORD_REQUIREMENTS
end
