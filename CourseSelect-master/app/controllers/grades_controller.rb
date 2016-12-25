class GradesController < ApplicationController

  before_action :teacher_logged_in, only: [:update, :courses]

  def update
    @grade=Grade.find_by_id(params[:id])
    if !@grade.nil? && @grade.update(:grade => params[:grade][:grade])
      flash={:success => "#{@grade.user.name} #{@grade.course.name}的成绩已成功修改为 #{@grade.grade}"}
    else
      flash={:danger => "上传失败.请重试"}
    end
    redirect_to grades_path(course_id: params[:course_id]), flash: flash
  end

  def index
    if teacher_logged_in?
      @course=Course.find_by_id(params[:course_id])
      @grades=@course.grades.order(user_id: :asc)
    elsif student_logged_in?
      @grades=current_user.grades
    else
      redirect_to root_path, flash: {:warning=>"请先登陆"}
    end
  end

  def course
    if teacher_logged_in?
      @course=Course.where(teacher_id: current_user)
    elsif
      redirect_to root_path, flash: {:warning=>"请先登录"}
    end
  end

  def chart
    if teacher_logged_in?
      @course=Course.where(teacher_id: current_user)
    elsif
      redirect_to root_path, flash: {:warning=>"请先登录"}
    end
  end

  def chart_bar
    if teacher_logged_in?
      @course=Course.find_by_id(params[:course_id])
      @grades=@course.grades
    end
    render json: grade_avg_dist
  end

  def chart_pie
    if teacher_logged_in?
      @course=Course.find_by_id(params[:course_id])
      @grades=@course.grades
    end
    render json: grade_dist
  end

  def excel
    if teacher_logged_in?
      @course=Course.find_by_id(params[:course_id])
      @grades=@course.grades
      respond_to do |format|
        format.xls
      end
    end
  end



  private

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def grade_dist
    grade_dist={'60': 0, '70': 0, '80': 0, '90': 0, '100': 0}
    @grades.each do |grade|
      case grade.grade
        when (0..60)
          grade_dist[:'60'] += 1
        when (60..70)
          grade_dist[:'70'] += 1
        when (70..80)
          grade_dist[:'80'] += 1
        when (80..90)
          grade_dist[:'90'] += 1
        when (90..100)
          grade_dist[:'100'] += 1
      end
    end
    grade_dist
  end

  def grade_avg_dist
    grade_dist=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @grades.each do |grade|
      case grade.grade
        when (0..10)
          grade_dist[0] += 1
        when (10..20)
          grade_dist[1] += 1
        when (20..30)
          grade_dist[2] += 1
        when (30..40)
          grade_dist[3] += 1
        when (40..50)
          grade_dist[4] += 1
        when (50..60)
          grade_dist[5] += 1
        when (60..70)
          grade_dist[6] += 1
        when (70..80)
          grade_dist[7] += 1
        when (80..90)
          grade_dist[8] += 1
        when (90..100)
          grade_dist[9] += 1
      end
    end
    grade_dist
  end

end
