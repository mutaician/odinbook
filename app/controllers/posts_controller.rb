class PostsController < ApplicationController
  before_action :authorize_edit, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: 'Post was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def authorize_edit
    @post = Post.find(params[:id])
    unless current_user == @post.user
      redirect_to root_path, alert: 'You are not authorized to edit this post.'
    end
  end
end
