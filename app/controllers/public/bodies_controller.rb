class Public::BodiesController < ApplicationController
  before_action :set_novel, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_novel_body, only: [:new, :create, :update]

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
    @novel_body.assign_attributes(body_params)
    if @novel_body.save
      redirect_to public_novel_body_path(@novel,@novel_body)
    else
      render :edit
    end

  end

  def destroy
    @novel.destroy
    redirect_to
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
