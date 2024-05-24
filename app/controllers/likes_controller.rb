class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    if @like.save
      redirect_to Post.find(params[:post_id])
    else
      # Handle the error here, e.g., redirect to the home page with an error message.
      redirect_to root_path, alert: "Unable to like post."
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like
      @like.destroy
      redirect_to Post.find(params[:post_id])
    else
      # Handle the error here, e.g., redirect to the home page with an error message.
      redirect_to root_path, alert: "Unable to unlike post."
    end
  end
end
