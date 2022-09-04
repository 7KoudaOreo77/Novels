class Public::NovelCommentsController < ApplicationController
  def create
    novel = Novel.find(params[:book_id])
    comment = current_user.novel_comments.new(public_novel_comment_params)
    comment.novel_id = novel.id
    comment.save
    redirect_to public_novel_path(novel)
  end

  def destroy
   NovelComment.find(params[:id]).destroy
   redirect_to public_novel_path(params[:novel_id])
  end

  private

  def public_novel_commnet_params
    params.require(:novel_commnet).permit(:comment)
  end
end
