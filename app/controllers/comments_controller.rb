# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment could not be created.'
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id || current_user.id == @post.user_id
      @comment.destroy
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
