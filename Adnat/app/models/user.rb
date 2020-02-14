class User < ApplicationRecord
    #belongs_to :organisation
    has_many :shifts

    has_secure_password

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email_address
    validates_uniqueness_of :email_address
end
