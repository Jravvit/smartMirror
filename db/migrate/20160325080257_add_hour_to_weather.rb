class AddHourToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :hour, :integer
  end
end
