class Public::SlicePagesController < ApplicationController
  def create
    @slice_page = current_user.slice_pages.find_or_initialize_by(novel_id: params[:novel_id])
    if @slice_page.new_record?
      @slice_page.url = params[:url]
      @slice_page.save
      flash[:notice] = "登録しました。"
    end
      redirect_back(fallback_location: root_url)
  end

  def update
    @slice_page = SlicePage.find_by(id: params[:id])
    @slice_page.update(url: params[:url]) if @slice_page
    flash[:notice] = "変更しました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @slice_page = SlicePage.find_by(id: params[:id])
    @slice_page.destroy if @slice_page
    flash[:notice] = "削除しました。"
    redirect_back(fallback_location: root_url)
  end
end
