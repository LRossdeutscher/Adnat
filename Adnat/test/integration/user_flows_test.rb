require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
    fixtures :users

    test "login and get welcome" do
        # login via https
        https!
        get '/log_in'
        assert_response :success

        post_via_redirect '/log_in', :email => users(:billy).email_address, :password => users(:billy).password
        assert_equal '/welcome', path
    end

end
