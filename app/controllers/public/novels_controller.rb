class Public::NovelsController < ApplicationController
  def new
    @novel = Novel.new
    @novel.bodies.build
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.user_id = current_user.id
    @user = current_user

    # save tags
    tag_list=params[:novel][:tag].split(',')

    if @novel.save
      @novel.save_tag(tag_list)
      flash[:hoge] = "小説が作成されました。"
      redirect_to public_novel_path(@novel.id)
    else
      render :new
    end
    
    # 投稿ボタンを押下した場合
    if params[:post]
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe), notice: "レシピを投稿しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きボタンを押下した場合
    else
      if @post_recipe.update(is_draft: true)
        redirect_to user_path(current_user), notice: "レシピを下書き保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end

  end

  def index
    #@novels = Novel.where(tag_id: 4)
    @novels = Novel.page(params[:page]).per(10).order(created_at: :desc)
    @tag_list=Tag.all
    #@novel = Novel.new
    @user = current_user
    #@tag = Tag.find_by(params[:tag_id])
  end

  def show
    @novel = Novel.find(params[:id])
    @user = @novel.user
    @novel_new = Novel.new

    @novel_comment = NovelComment.new
    #@novel_tags = @novel.tags
  end

  def edit
    @novel = Novel.find(params[:id])
  #@tag_list=@novel.tags.pluck(:name).join(',')

    if @novel.user == current_user
     render "edit"
    else
     redirect_to public_novels_path
    end
  end

  def update
    @novel = Novel.find(params[:id])
    @user = current_user
    tag_list=params[:novel][:tag].split(',')

    if @novel.update(novel_params)
      @novel.save_tag(tag_list)
      flash[:hoge] = "小説が更新されました。"
      redirect_to public_novel_path(@novel.id)
    else
      render :edit
    end
    
    
    @post_recipe = PostRecipe.find(params[:id])
    # ①下書きレシピの更新（公開）の場合
    if params[:publicize_draft]
      # レシピ公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @post_recipe.attributes = post_recipe_params.merge(is_draft: false)
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe.id), notice: "下書きのレシピを公開しました！"
      else
        @post_recipe.is_draft = true
        render :edit, alert: "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
      # ②公開済みレシピの更新の場合
    elsif params[:update_post]
      @post_recipe.attributes = post_recipe_params
      if @post_recipe.save(context: :publicize)
        redirect_to post_recipe_path(@post_recipe.id), notice: "レシピを更新しました！"
      else
        render :edit, alert: "レシピを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ③下書きレシピの更新（非公開）の場合
    else
      if @post_recipe.update(post_recipe_params)
        redirect_to post_recipe_path(@post_recipe.id), notice: "下書きレシピを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
    
    
  end


  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    redirect_to '/public/novels'
  end

  def search
   if params[:keyword].present?
      #@novels = Novel.where('title LIKE ? or body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @novels = Novel.joins(:bodies).where('title LIKE ? or novel_bodies.body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
      @keyword = params[:keyword]
   else
      @novels = Novel.all
   end
  end

  def tag_search

    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @novels = @tag.novels.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def novel_params
    params.require(:novel).permit(:title, :image, bodies_attributes:[:subtitle, :body])
  end
end
