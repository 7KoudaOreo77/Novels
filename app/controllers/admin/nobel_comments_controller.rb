class Admin::NovelCommentsController < ApplicationController
  def create
    novel = Novel.find(params[:book_id])
    comment = current_user.novel_comments.new(admin_novel_comment_params)
    comment.novel_id = novel.id
    comment.save
    redirect_to admin_novel_path(novel)
  end

  def destroy
   NovelComment.find(params[:id]).destroy
   redirect_to admin_novel_path(params[:novel_id])
  end

  private

  def admin_novel_commnet_params
    params.require(:novel_commnet).permit(:comment)
  end
end
