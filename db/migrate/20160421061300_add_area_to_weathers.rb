class AddAreaToWeathers < ActiveRecord::Migration
  def change
    add_reference :weathers, :area, index: true, foreign_key: true
  end
end
