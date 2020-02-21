require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
    test "should create organisation" do
        assert_difference('Organisation.count') do
            get(:create, { 'organisation' => { 'name' => "Maccas", 'hourly_rate' => 10 } }, {'user_id' => 1})
        end
        assert_redirected_to overview_path(assigns(:organisation))
    end
end
