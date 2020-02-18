class ChangeBreakLengthToInteger < ActiveRecord::Migration[6.0]
  def change
      change_column :shifts, :break_length, :integer, using: 'break_length::integer'
  end
end
