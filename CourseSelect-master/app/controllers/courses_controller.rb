class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create , :destroy , :coursedestory ]
  before_action :admin_logged_in, only: [:passcourse, :arrangecourse]
  before_action :logged_in, only: :index

  $CourseReview = 0
  $CourseArrange = 1
  $CourseClose = 2
  $CourseOpen = 3
  $CourseUnpass = 4

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.teacher_id=current_user.id
    #@course.course_code = 'HD'+ @course.id.to_s
    if @course.save
      #current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    if !student_logged_in?
      @course=Course.find_by_id(params[:id])
    end
  end

  def update
    if !student_logged_in?
      @course = Course.find_by_id(params[:id])
      if @course.update_attributes(course_params)
        flash={:info => "更新成功"}
      else
        flash={:warning => "更新失败"}
      end
      redirect_to courses_path, flash: flash
    end
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    #current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end
  
  def coursedestory
    @course=Course.find_by_id(params[:id])
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end
  
  def opencourse
    @course=Course.find_by_id(params[:id])
    if @course[:status] != $CourseReview && @course.update_attributes(:status=>$CourseOpen)
        flash={:info =>"开课成功"}
    else
        flash={:warning => "操作失败,请重试!"}
    end  
    redirect_to courses_path, flash: flash
  end
  
  def closecourse
    @course=Course.find_by_id(params[:id])
    if @course[:status] != $CourseReview && @course.update_attributes(:status=>$CourseClose)
        flash={:info =>"该课程已关闭"}
    else
        flash={:warning => "操作失败,请重试!"}
    end  
    redirect_to courses_path, flash: flash
  end

  def grade
    @course=Course.where(teacher_id: current_user)
  end
  
  #重新申请
  def applycourse
    @course=Course.find_by_id(params[:id])
    if @course[:status] == $CourseUnpass && @course.update_attributes(:status=>$CourseReview)
      flash={:info =>"申请成功"}
    else
      flash={:warning => "操作失败,请重试!"}
    end
    redirect_to courses_path, flash: flash 
  end
  
  #-------------------------for students----------------------

  def list
    @course=Course.all
    @course=@course-current_user.courses
    @course = @course.select{|course| course.open?&&course.status==$CourseOpen}
  end

  def select
    @course=Course.find_by_id(params[:id])
    current_user.courses<<@course
    flash={:success => "成功选择课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  def quit
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end
  
  def checkroom
  end

  def checkemptyroom
      
  end
  #-------------------------for admin----------------------
  
  #通过审核
  def passcourse
    @course=Course.find_by_id(params[:id])
    if @course[:status] == $CourseArrange
      if @course.update_attributes(:status=>$CourseClose)
        flash={:info =>"审核通过"}
      else
        flash={:warning => "操作失败,请重试!"}
      end
    else
      flash={:warning => "请先排课!"}
    end  
    redirect_to courses_path, flash: flash
  end
  
  #审核不通过
  def nopasscourse
    @course=Course.find_by_id(params[:id])
    if @course.update_attributes( :status=>$CourseUnpass)
      flash={:info =>"审核不通过"}
    else
      flash={:warning => "操作失败,请重试!"}
    end
    redirect_to courses_path, flash: flash
  end
  
  #排课
  def arrangecourse
    @course=Course.find_by_id(params[:id])
    
    course_time = @course.course_time[0..-2] #去掉最后一个字符）
    time = course_time.split('(')
    weeknum = time[0]
    start_time = time[1].split('-')[0].to_i  #课程开始长度
    end_time = time[1].split('-')[1].to_i
    course_length = end_time - start_time + 1 #计算课程长度
    room_size = @course.limit_num  #限选人数
    campus = @course.campus  #校区
    
    tmp_arranges = Arrange.where("course_id is null")
    tmp_hash = Hash.new
    tmp_arranges.each do |arrange|
        tmp_classtime = arrange.classtime
        tmp_classroom = arrange.classroom
        if tmp_classtime.weekday == weeknum && tmp_classtime.phase >= start_time && tmp_classtime.phase <= end_time && tmp_classroom.volume.to_i >= room_size && tmp_classroom.campus == campus 
          if !tmp_hash.has_key?(arrange.classroom_id)  #如果hash表中还没有该教室
            tmp_hash[arrange.classroom_id] = Array.new            
          end
          tmp_hash[arrange.classroom_id].push(arrange)
        end
    end
    
    @arranges_array = Array.new
    tmp_hash.each do |room_id,item|
      if item.size == course_length  #符合条件
        @arranges_array.push(item)
      end
    end
    
    if @arranges_array.size == 0
      flash={:warning => "没有符合条件的教室，请调整条件!"}
      redirect_to courses_path, flash: flash
    end
 
  end
  
  #排课确认
  def arrangeconfirm
    arrange_ids = params[:arrange_ids]
    course_id = params[:id]
    class_room = ""
    arrange_ids.each do |arrange_id|
      @arrange = Arrange.find_by_id(arrange_id)
      class_room = @arrange.classroom.building + @arrange.classroom.name
      @arrange.update_attributes(:course_id=>course_id)
    end
    @course = Course.find_by_id(course_id)
    if @course.update_attributes(:class_room=>class_room,:status=>$CourseArrange)
      
      flash={:info => "安排完毕"}
    else
      flash={:warning => "操作失败,请重试!"}
    end  
    redirect_to courses_path, flash: flash
  end
  
  #选课控制
  def control
    @course = Course.where('status = 2 or status = 3')
  end
  
  def openselect
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(:open=>true)
      flash={:info =>"开选成功"}
    else
      flash={:warning => "操作失败,请重试!"}
    end
    redirect_to control_courses_path, flash: flash  
  end
  
  def closeselect
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(:open=>false)
      flash={:info =>"关闭成功"}
    else
      flash={:warning => "操作失败,请重试!"}
    end
    redirect_to control_courses_path, flash: flash  
  end
  
  def openall
    @course = Course.where('status = 2 or status = 3')
    @course.each do |course|
      course.update_attributes(:open=>true)
    end
    flash={:info =>"开放成功"}
    redirect_to control_courses_path, flash: flash
  end
  
  def closeall
    @course = Course.where('status = 2 or status = 3')
    @course.each do |course|
      course.update_attributes(:open=>false)
    end
    flash={:info =>"关闭成功"}
    redirect_to control_courses_path, flash: flash 
  end
  

  #-------------------------for both teachers and students----------------------

  def index
    @course=Course.where(teacher_id: current_user) if teacher_logged_in?
    @course=current_user.courses if student_logged_in?
    @course = Course.where(status: [$CourseReview,$CourseArrange]) if admin_logged_in?
  end

  def discussion
    @course=Course.where(teacher_id: current_user) if teacher_logged_in?
    @course=current_user.courses if student_logged_in?
  end
  
  
  def coursetable
    @tables = Array.new(12){Array.new(7,'0')}
#    @course = current_user.courses  
    @course=Course.where(teacher_id: current_user) if teacher_logged_in? #获取老师课表
    @course=current_user.courses if student_logged_in? #获取学生课程
    
    @week_now = nowWeek  #计算当前第几周
    @course.each_with_index do |wn_course , course_index|     #样例： 周五(5-6)&周三(5-6)
      course_times = wn_course.course_time.split('&') #将每个时间点切出
      course_times.each do |course_time|    #循环处理每个时间点
        course_time = course_time[0..-2] #去掉最后一个字符）
        time = course_time.split('(')
        weeknum = transformWeek(time[0])
        start_time = time[1].split('-')[0].to_i
        course_length = time[1].split('-')[1].to_i - start_time + 1 #计算课程长度
        @tables[start_time-1][weeknum] = course_index.to_s + "@" + course_length.to_s
      end
    end
  end
  

  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end
  
  def admin_logged_in
    unless admin_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end  
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week, :campus)
  end
  
  #周次转数字
  def transformWeek(weekString)
      weeks = ['周一','周二','周三','周四','周五','周六','周日']
      weeks.each_with_index do |week , index|
          if week == weekString
              return index
          end
      end
  end
  
  #返回当前周次   8月29开学
  def nowWeek
      day_start = Date.new(2016,8,29).strftime("%W").to_i
      day_now = Time.now.strftime("%W").to_i
      if day_now < day_start
          day_now += 52
      end
      return day_now - day_start
  end

end
