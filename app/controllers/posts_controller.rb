class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(post_params.merge(user: current_user))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to :back
    end
    # We also should test that the user is allowed to modify posts in our controller
    # actions, like above
  end

  def update
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to :back
    end
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to :back
    end
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
