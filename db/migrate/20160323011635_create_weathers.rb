class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.datetime :date
      t.string :state
      t.string :image

      t.timestamps null: false
    end
  end
end
