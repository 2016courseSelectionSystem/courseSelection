class Comment < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user

  validates :content, presence: true
end
