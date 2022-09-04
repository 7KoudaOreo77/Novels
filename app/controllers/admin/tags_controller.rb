class Admin::TagsController < ApplicationController
  def index
    @tag_new = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(admin_tag_params)
    @tag.save
    redirect_to admin_tags_path
  end

  def edit
    @tag = Tag.find_by(id: params[:id])
  end

  def update
    @tag = Tag.find_by(id: params[:id])
    @tag.name = params[:tag][:name]
    if @tag.save
      redirect_to admin_tags_path
    else
      render edit_admin_tag_path
    end
  end

  private

  def admin_tag_params
    params.require(:tag).permit(:name)
  end

end
