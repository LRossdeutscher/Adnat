require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @user = users(:billy)
        post '/sessions', params: { email: @user.email_address, password: @user.password_digest }
    end

    teardown do
        Rails.cache.clear
        get '/log_out'
    end

    test "should create organisation" do
        # I couldn't figure out how to authenticate a user to access
        # the action correctly, or the use of stubs.
        #User.stubs(:authorized).returns true
        assert_difference('Organisation.count') do
            post '/organisations', params: { organisation: { name: "Maccas", hourly_rate: 10 } }
        end
        assert_redirected_to overview_path(Organisation.last)
    end
end
