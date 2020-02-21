require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "valid_user" do
        user = User.create(name: "Lucas", email_address: "lucas@gmail.com", organisation_id: nil, password_digest: "password123")
        assert user.errors.any?, user.errors.full_messages
    end

    test "invalid_user_1" do
        user = User.new
        assert !user.save, "Created a user with nil attributes"
    end

    test "invalid_user_2" do
        user = User.create(name: "", email_address: "lucas@gmail.com", organisation_id: nil, password_digest: "password123")
        assert user.errors.any?, "Created a user with an empty name"
    end

    test "invalid_user_3" do
        user = User.create(name: "Lucas", email_address: "", organisation_id: nil, password_digest: "password123")
        assert user.errors.any?, "Created a user with an empty email"
    end

    test "invalid_user_4" do
        user = User.create(name: "Lucas", email_address: "Lucasgmail.com", organisation_id: nil, password_digest: "password123")
        assert user.errors.any?, "Created a user with an invalid email"
    end

    test "invalid_user_5" do
        user = User.create(name: "Lucas", email_address: "Lucas@gmail.com", organisation_id: 1000, password_digest: "password123")
        assert user.errors.any?, "Created a user with an organisation_id that does not exist"
    end

    test "invalid_user_6" do
        user = User.create(name: "Lucas", email_address: "Lucas@gmail.com", organisation_id: nil, password_digest: "123")
        assert user.errors.any?, "Created a user with a password less than 6 characters"
    end

    test "invalid_user_7" do
        user = User.create(name: "Lucas", email_address: "Lucas@gmail.com", organisation_id: nil, password_digest: "")
        assert user.errors.any?, "Created a user with a password that was empty"
    end
end
