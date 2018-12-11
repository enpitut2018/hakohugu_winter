class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:index,:new, :update,:show]
  before_action :correct_user,   only: [:show]
  def index
    @user = User.find(current_user.id)
    @documents = @user.documents.all
  end

  def new
    @document = Document.new
    @templates = Template.all
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to "/documents/#{@document.id}"
    else
      render 'new'
    end

  end

  def show
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(update_params)
  end

  def destroy
    if Document.find(params[:id]).destroy
      redirect_to documents_path
    else
      redirect_to documents_path
    end

  end

   private

    def update_params
      params.require(:document).permit(:content)
    end

    def document_params
      params.require(:document).permit(:title,:user_id,:template_id)
    end

     # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      document = Document.find(params[:id])
      @user = User.find(document.user_id)
      redirect_to('/') unless current_user?(@user)
    end
end
