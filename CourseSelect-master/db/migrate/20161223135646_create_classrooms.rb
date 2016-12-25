class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :campus
      t.string :volume
      t.string :building
      t.timestamps
    end
  end
end
