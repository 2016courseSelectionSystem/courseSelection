class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :discussion, index: true
      t.belongs_to :user, index: true

      t.text :content, null: false
      t.boolean :teacher, default: false
      t.integer :up, default: 0

      t.timestamps null: false
    end
  end
end
