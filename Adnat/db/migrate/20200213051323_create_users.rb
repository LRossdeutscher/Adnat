class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :organisation_id
      t.string :name
      t.string :email_address
      t.string :password

      t.timestamps
    end
  end
end
