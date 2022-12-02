class CreateBarbers < ActiveRecord::Migration[7.0]
  def change
    create_table :barber do |t|
      t.text :name

      t.timestamps
    end
  end
end
