class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    if current_user
      @user = User.find(current_user)
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    else
      redirect_to new_session_path
    end
  end

  def edit
  end

  def create

    @user = current_user
    @comment = Comment.new(params.require(:comment).permit(:content, :user_id, :post_id))
    @comment.user = current_user

    if @comment.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def update
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
