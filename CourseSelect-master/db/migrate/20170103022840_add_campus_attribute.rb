class AddCampusAttribute < ActiveRecord::Migration
  def change
	add_column :courses, :campus, :string, :default =>'西区'
  end
end
