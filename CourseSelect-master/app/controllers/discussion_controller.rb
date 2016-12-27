class DiscussionController < ApplicationController
  before_action :logged_in

  def index
    @course = Course.find(params[:course_id])
    @discussions = Discussion.where(course_id: params[:course_id])
  end

  def new
    @course = Course.find(params[:course_id])
    @discussion = Discussion.new
  end

  def create
    @course = Course.find(params[:course_id])
    @discussion = @course.discussions.new(discussion_params)
    @discussion.user_id = current_user.id
    if @discussion.save
      redirect_to course_discussion_path(id: @discussion, course_id: @course), flash: {success: "新讨论创建成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @discussion = @course.discussions.find(params[:id])
  end

  private

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def discussion_params
    params.require(:discussion).permit(:title, :content)
  end
end
