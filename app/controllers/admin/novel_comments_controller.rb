class Admin::NovelCommentsController < ApplicationController

  def index
   @comments = NovelComment.all
   @comments = @comments.page(params[:page]).per(5)
   #@user = User.find(admin_novel_commnet_params)
   #@user =
  end

  def create
    novel = Novel.find(params[:book_id])
    comment = current_user.novel_comments.new(admin_novel_comment_params)
    comment.novel_id = novel.id
    comment.save
    redirect_to admin_novel_path(novel)
  end

  def destroy
   NovelComment.find(params[:id]).destroy
   redirect_to admin_novel_comments_path
  end

  private

  def admin_novel_commnet_params
    params.require(:novel_commnet).permit(:comment)
  end
end
