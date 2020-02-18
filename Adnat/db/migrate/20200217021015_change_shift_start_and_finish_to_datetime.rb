class ChangeShiftStartAndFinishToDatetime < ActiveRecord::Migration[6.0]
  def change
      change_column :shifts, :start, :datetime
      change_column :shifts, :finish, :datetime
  end
end
