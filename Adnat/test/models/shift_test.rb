require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
    def additional_hours(hours)
        # return the time object equivalent of hours
        60 * 60 * hours
    end

    test "valid_shift" do
        shift = Shift.create(user_id: 1, start: Time.now, finish: Time.now + additional_hours(3), break_length: 30)
        assert !shift.errors.any?, shift.errors.full_messages
    end

    test "invalid_shift_1" do
        shift = Shift.new
        assert_not shift.save, "Created a shift with nil attributes"
    end

    test "invalid_shift_2" do
        shift = Shift.create(user_id: 10, start: Time.now, finish: Time.now + additional_hours(3), break_length: 30)
        assert shift.errors.any?, "Created a shift with a user_id that does not exist"
    end

    test "invalid_shift_3" do
        shift = Shift.create(user_id: 1, start: "", finish: Time.now + additional_hours(3), break_length: 30)
        assert shift.errors.any?, "Created a shift with an empty start time"
    end

    test "invalid_shift_4" do
        shift = Shift.create(user_id: 1, start: Time.now, finish: "", break_length: 30)
        assert shift.errors.any?, "Created a shift with an empty finish time"
    end

    test "invalid_shift_5" do
        shift = Shift.create(user_id: 1, start: Time.now, finish: Time.now + additional_hours(3), break_length: -1)
        assert shift.errors.any?, "Created a shift with a negative break length"
    end

    test "invalid_shift_6" do
        shift = Shift.create(user_id: 1, start: Time.now, finish: Time.now + additional_hours(3), break_length: 61)
        assert shift.errors.any?, "Created a shift with a break length longer than 60 minutes"
    end
end
