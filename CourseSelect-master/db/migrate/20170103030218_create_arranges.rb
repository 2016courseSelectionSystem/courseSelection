class CreateArranges < ActiveRecord::Migration
  def change
    create_table :arranges do |t|
      t.integer :course_id
      t.belongs_to :classtime, index: true
      t.belongs_to :classroom, index: true 

      t.timestamps null: false
    end
  end
end
