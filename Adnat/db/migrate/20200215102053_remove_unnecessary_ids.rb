class RemoveUnnecessaryIds < ActiveRecord::Migration[6.0]
  def change
      remove_column :users, :user_id
      remove_column :organisations, :organisation_id
      remove_column :shifts, :shift_id
  end
end
