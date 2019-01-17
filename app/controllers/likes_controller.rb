class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @template = Template.find(params[:template_id])
    unless @template.fav?(current_user)
      @template.fav(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @template = Like.find(params[:id]).template
    if @template.fav?(current_user)
      @template.unfav(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  private
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
