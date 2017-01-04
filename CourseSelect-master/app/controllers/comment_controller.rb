class CommentController < ApplicationController
  before_action :logged_in

  def index
    @course = Course.find(params[:course_id])
    @discussion = @course.discussions.find(params[:discussion_id])
    @comments = @discussion.comments
    @comment = Comment.new
  end

  def create
    @course = Course.find(params[:course_id])
    @discussion = @course.discussions.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to course_discussion_comment_index_path(course_id: @course, discussion_id: @discussion), flash: {success: "新回复创建成功"}
    else
      redirect_to course_discussion_comment_index_path(course_id: @course, discussion_id: @discussion), flash: {success: "回复创建失败"}
    end
  end


  private

  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
