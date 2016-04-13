class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]
  before_action :only_my_posts, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def edit

  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :image)
    end

     def only_my_posts
      redirect_to root_path, notice: "you can't edit someone elses posts" if (current_user != @post.user)
    end

end
