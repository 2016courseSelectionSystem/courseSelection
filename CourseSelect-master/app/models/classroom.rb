class Classroom < ActiveRecord::Base
    
    has_many :arranges
    has_many :classtimes, through: :arranges
    
end
