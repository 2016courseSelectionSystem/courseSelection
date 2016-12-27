class Course < ActiveRecord::Base

  has_many :grades
  has_many :users, through: :grades
  has_many :discussions
  has_many :comments, through: :discussions

  belongs_to :teacher, class_name: "User"

  validates :name, :course_type, :credit, :teaching_type, :exam_type, presence: true, length: {maximum: 50}
end
