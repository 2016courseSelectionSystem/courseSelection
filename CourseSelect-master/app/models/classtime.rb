class Classtime < ActiveRecord::Base
    
    has_many :arranges
    has_many :classrooms, through: :arranges

end
