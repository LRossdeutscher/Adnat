require '../test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get '/log_in'
    assert_response :success
  end

  test "should redirect logout" do
    get '/log_out'
    assert_response :redirect, "Logged out without being logged in"
  end

  test "should redirect overview" do
    get '/overview'
    assert_response :redirect, "Accessed organisation overview page without being logged in"
  end

  test "should redirect welcome" do
    get '/welcome'
    assert_response :redirect, "Accessed Adnat welcome page without being logged in"
  end

  test "login and get welcome" do
    get '/welcome'
    assert_response :success
  end

end
