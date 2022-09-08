class Public::TagsController < ApplicationController
  def index
    @tag_new = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(public_tag_params)
    @tag.save
    redirect_to public_tags_path
  end

  def show
   @novel = Novel.find(params[:id])
   @tags = @novel.tag_counts_on(:tags)
  end

  def edit
    @tag = Tag.find_by(id: params[:id])
  end

  def update
    @tag = Tag.find_by(id: params[:id])
    @tag.name = params[:tag][:name]
    if @tag.save
      redirect_to public_tags_path
    else
      render edit_public_tag_path
    end
  end

  private

  def public_tag_params
    params.require(:tag).permit(:name)
  end

end
