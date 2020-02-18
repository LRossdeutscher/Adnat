class ChangeIdColumnsToIntegers < ActiveRecord::Migration[6.0]
  def change
      change_column :users, :organisation_id, :integer, using: 'organisation_id::integer'
      change_column :shifts, :user_id, :integer, using: 'user_id::integer'
  end
end
