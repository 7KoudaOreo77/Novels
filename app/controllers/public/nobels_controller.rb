class Public::NobelsController < ApplicationController
  def new
    @novel = Novel.new
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.user_id = current_user.id
    @user = current_user

    if @novel.save
      flash[:hoge] = "Novel was successfully created."
      redirect_to public_novel_path(@novel.id)
    else
      @novels = Novel.all
      render :index
    end
  end

  def index
    @novels = Novel.all
    @novel = Novel.new
    @user = current_user
  end

  def show
    @novel = Novel.find(params[:id])
    @user = @novel.user
    @novel_new = Novel.new

    @novel_comment = NovelComment.new
  end

  def edit
    @novel = Novel.find(params[:id])
    if @novel.user == current_user
     render "edit"
    else
     redirect_to public_novels_path
    end
  end

  def update
    @novel = Novel.find(params[:id])
    @user = current_user

    if @novel.update(novel_params)
      flash[:hoge] = "You have updated novel successfully."
      redirect_to public_novel_path(@novel.id)
    else
      render :edit
    end
  end


  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    redirect_to '/novels'
  end

  private

  def novel_params
    params.require(:novel).permit(:title, :body)
  end
end
