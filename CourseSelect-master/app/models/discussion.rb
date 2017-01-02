class Discussion < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {maximum: 100}
end
