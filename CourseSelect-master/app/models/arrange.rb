class Arrange < ActiveRecord::Base
    belongs_to :classroom
    belongs_to :classtime
 
    
    def getclassinfo
        if self.course_id.nil?
            return false
        else
            @course = Course.find_by_id(self.course_id)
            return @course
        end
    end
end
