class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.string :shift_id
      t.string :user_id
      t.string :start
      t.string :finish
      t.string :break_length

      t.timestamps
    end
  end
end
