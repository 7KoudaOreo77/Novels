class Public::FavoritesController < ApplicationController
  def create
    novel = Novel.find(params[:novel_id])
    favorite = current_user.favorites.new(novel_id: novel.id)
    favorite.save
    redirect_to novel_path(novel)
  end

  def destroy
    novel = Novel.find(params[:novel_id])
    favorite = current_user.favorites.new(novel_id: novel.id)
    favorite.save
    redirect_to novel_path(novel)
  end
end
