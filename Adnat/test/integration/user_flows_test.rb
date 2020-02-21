require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
    fixtures :users

    test "login and get welcome" do
        # login via https
        https!
        get '/log_in'
        assert_response :success

        post '/sessions', params: { email: users(:billy).email_address, password: users(:billy).password_digest }
        follow_redirect!
        assert_equal '/welcome', path
    end

end
