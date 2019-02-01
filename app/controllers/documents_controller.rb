class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:index,:new, :update,:show]
  before_action :correct_user,   only: [:show]
  protect_from_forgery except: :test
  
  def index
    @user = User.find(current_user.id)
    @documents = @user.documents.all
  end

  def new
    @document = Document.new
    logger.debug(params[:template_id])
  end

  def create
    test = params["test"]
    @document = Document.new(document_params)
    if @document.save
      if test
        redirect_to "/documents/#{@document.id}?test=1"
      else
        redirect_to "/documents/#{@document.id}"
      end
    else
      render 'new'
    end

  end

  def show
    @document = Document.find(params[:id])
    @template = Template.find(@document.template_id)
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

  def test
    @document = Document.find(params[:id])
    @template = @document.template
    if @document.destroy
      redirect_to @template
    end
  end

   private

    def update_params
      params.require(:document).permit(:title,:content,:conversation_logs,:question_number,:count_t,:count_d,:count_e,:count_called_h,:sum_h)
    end

    def document_params
      params.require(:document).permit(:title,:template_id).merge(user_id: current_user.id)
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
