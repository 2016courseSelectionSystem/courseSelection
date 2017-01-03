class ClassroomController < ApplicationController
  def index
      @classroom = Classroom.all
  end
  
  
  def edit
      @classroom = Classroom.new
  end
  
  #新建classroom
  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
        @times = Classtime.all
        @times.each do |time|
          Arrange.create(classtime_id: time.id, classroom_id: @classroom.id)
        end
        redirect_to classroom_index_path, flash: {success: "新教室创建成功"+@classroom.id.to_s}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'edit'
    end
  end
  
  
  private
  def classroom_params
    params.require(:classroom).permit(:name, :campus, :building, :volume)
  end
end
