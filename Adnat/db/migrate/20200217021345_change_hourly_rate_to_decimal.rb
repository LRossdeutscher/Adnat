class ChangeHourlyRateToDecimal < ActiveRecord::Migration[6.0]
  def change
      change_column :organisations, :hourly_rate, :decimal, using: 'hourly_rate::decimal'
  end
end
