class Grade < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates_numericality_of :grade, allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: '分数必须在0到100之间的数'
end
