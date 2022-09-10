class Public::FavoritesController < ApplicationController
  def create
    @novel = Novel.find(params[:novel_id])
    favorite = current_user.favorites.new(novel_id: @novel.id)
    favorite.save
#    redirect_to public_novel_path(novel)
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    favorite = current_user.favorites.find_by(novel_id: @novel.id)
    if favorite.present?
      favorite.destroy
    end
#    redirect_to public_novel_path(novel)

  end
end
