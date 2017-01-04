class CreateClasstimes < ActiveRecord::Migration
  def change
    create_table :classtimes do |t|
      t.string :weekday
      t.integer :phase

      t.timestamps null: false
    end
  end
end
