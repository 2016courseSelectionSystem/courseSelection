class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true

      t.string :title, null: false
      t.text :content

      t.timestamps null: false
    end
  end
end
