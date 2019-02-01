class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:index,:new, :update,:show]
  before_action :correct_user,   only: [:show]
  
  def index
    @user = User.find(current_user.id)
    @documents = @user.documents.all
  end

  def new
    @document = Document.new
    logger.debug(params[:template_id])
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

  def release
    @document = Document.find(params[:id])
    if @document.scope == 0
      val = 1
    elsif @document.scope == 1
      val = 0
    end

    if @document.update(scope: val)
      @documents = Document.where('scope = ?',1)
      redirect_to documents_open_path
    else
      render 'index'
    end
  end

  def open
    @documents = Document.where('scope = ?',1)
    @user = User.find(current_user.id)
  end

  def read
    @document = Document.find(params[:id])
    @template = Template.find(@document.template_id)
    @category=Category.find(@template.category_id)
    @questions=Question.where(template_id: @template.id)
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
