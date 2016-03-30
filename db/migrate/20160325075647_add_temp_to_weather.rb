class AddTempToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :temp, :integer
  end
end
