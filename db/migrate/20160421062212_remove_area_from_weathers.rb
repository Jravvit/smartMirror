class RemoveAreaFromWeathers < ActiveRecord::Migration
  def change
    remove_column :weathers, :area, :string
  end
end
