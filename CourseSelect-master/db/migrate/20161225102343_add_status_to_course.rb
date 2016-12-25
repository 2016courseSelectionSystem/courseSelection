class AddStatusToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :status, :integer, default: 0
  end
end
