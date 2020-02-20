require '../test_helper'

class OrganisationTest < ActiveSupport::TestCase
    test 'valid_organisation' do
        organisation = Organisation.create(name: "Jim's Mowing", hourly_rate: 10)
        assert !organisation.errors.any?, organisation.errors.full_messages
    end

    test 'invalid_organisation_1' do
        organisation = Organisation.create(name: "Bob's Burgers", hourly_rate: 10)
        assert organisation.errors.any?, "Created organisation with taken name"
    end

    test 'invalid_organisation_2' do
        organisation = Organisation.create(name: "", hourly_rate: -1)
        assert organisation.errors.any?, "Created organisation with an empty name"
    end

    test 'invalid_organisation_3' do
        organisation = Organisation.new
        assert !organisation.save, "Created organisation with nil attributes"
    end

    test 'invalid_organisation_4' do
        organisation = Organisation.create(name: "Krispy Kreme's", hourly_rate: -1)
        assert organisation.errors.any?, "Created organisation with a negative hourly rate"
    end
end
