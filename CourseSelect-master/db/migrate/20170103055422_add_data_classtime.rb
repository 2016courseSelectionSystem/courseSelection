class AddDataClasstime < ActiveRecord::Migration
  def up
	a = Array['周一','周二','周三','周四','周五','周六','周日']
	a.each do |week|
		(1..12).each do |i|
			Classtime.create(weekday: week,phase: i )
		end
	end
  end
end
