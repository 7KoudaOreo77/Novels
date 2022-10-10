class Public::BodiesController < ApplicationController
  before_action :set_novel, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_novel_body, only: [:new, :create]

  def new
  end

  def show
    @novel = Novel.find(params[:novel_id])
    @novel_body = NovelBody.find(params[:id])
    @current_page = (params[:page] || 1).to_i
    @body_text, @max_page = @novel_body.page(@current_page)
  end

  def edit
    @novel_body = @novel.bodies.find(params[:id])
  end

  def create
    @novel_body.assign_attributes(body_params)
    if @novel_body.save
      redirect_to public_novel_body_path(@novel,@novel_body)
    else
      render :new
    end
  end

  def update
    @novel_body = NovelBody.find(params[:id])
    @novel = @novel_body.novel
    if @novel_body.update(body_params)
      flash[:notice] = "編集しました。"
      redirect_to public_novel_body_path(@novel, @novel_body)
    else
      flash[:danger] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @novel_body = NovelBody.find(params[:id])
    if @novel_body.destroy
     redirect_to public_novel_path(@novel)
    else
      render :index
    end
  end

  def move_higher
    NovelBody.find(params[:id]).move_higher #move_higherメソッドでpositionを上に
    redirect_back(fallback_location: root_url)
  end

  def move_lower
    NovelBody.find(params[:id]).move_lower #move_lowerメソッドでpositionを下に
    redirect_back(fallback_location: root_url)
  end

  private

  def set_novel
    @novel = current_user.novels.find(params[:novel_id])
  end

  def set_novel_body
    @novel_body = @novel.bodies.new
  end

  def body_params
    params.require(:novel_body).permit(:subtitle, :body)
  end
end
