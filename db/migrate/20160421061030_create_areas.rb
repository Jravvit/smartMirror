class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :address
      t.integer :x
      t.integer :y

      t.timestamps null: false
    end
  end
end
