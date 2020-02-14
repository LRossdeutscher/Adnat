class CreateOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :organisations do |t|
      t.string :organisation_id
      t.string :name
      t.string :hourly_rate

      t.timestamps
    end
  end
end
