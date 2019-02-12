class TemplatesController < ApplicationController
  before_action :logged_in_user

  def index
    @templates=Template.paginate(page: params[:page],:per_page => 8).search(params[:search],params[:select]).where(scope: 1).order('likes_count DESC')
    @user = User.find(current_user.id)
    @my_templates_unreleased=@user.templates.where(scope: 0)
    @my_templates_released=@user.templates.where(scope: 1).order('likes_count DESC')
  end

  def new
    @template=Template.new
    @category=Category.new
    @submit='作成'
    @parents_template_id = params[:id]
    @questions = params[:id]
    if @parents_template_id
      @parents_template = Template.find(@parents_template_id)
      @questions = Question.where(template_id: @parents_template_id)
    end
    
  end

  def show
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)
    @questions=Question.where(template_id: @template.id)
    @document = Document.new
  end

  def create
    @category=Category.new(category_params)
    if @category.save
      @template=Template.new(template_params)
      @template.category_id = @category.id
      @template.scope = 0
      if @template.save
        redirect_to templates_path
      else
        @category.destroy
        redirect_to new_template_path, alert: "アシスタントのタイトル、または概要を入力してください。"
      end
    else
       redirect_to new_template_path, alert: "カテゴリを入力してください。"
    end
  end

  def edit
    @template=Template.find(params[:id])
    @category=Category.find(@template.category.id)
    @submit='更新'
    @questions=Question.where(template_id: @template.id)
  end

  def update
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)
    if @category.update_attributes(category_params)
      if @template.update_attributes(template_params)
        render 'show'
      else
        redirect_to edit_template_path, alert: "アシスタントのタイトル、概要、またはカテゴリを入力してください。"
      end
    else
      redirect_to edit_template_path, alert: "アシスタントのタイトル、概要、またはカテゴリを入力してください。"
    end
  end

  def destroy
    if Template.find(params[:id]).destroy
      redirect_to templates_path
    else
      render 'show'
    end
  end

  def release
    @template = Template.find(params[:id])

    if @template.update(scope: 1)
      redirect_to templates_path
    else
      render 'show'
    end
  end

  private

    def template_params
        params.require(:template).permit(:title,:topic,:category_id,:picture,questions_attributes: [:id, :qtext, :qdetail, :example, :_destroy]).merge(user_id: current_user.id)
    end

    def category_params
        params.require(:category).permit(:name)
    end

  # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

end
