class TemplatesController < ApplicationController
  before_action :logged_in_user

  def index
    @templates=Template.paginate(page: params[:page],:per_page => 8).search(params[:search],params[:select]).where(scope: 1).order('likes_count DESC')
    @user = User.find(current_user.id)
    @my_templates_unreleased=@user.templates.where(scope: 0)
    @my_templates_released=@user.templates.where(scope: 1).order('likes_count DESC')

    @templates_released = Template.where(scope: 1)
    @category_name = []
    @templates_released.each do |template_released|
      @category_name.push(template_released.category.name)
    end

    @category_name =  @category_name.each_with_object(Hash.new(0)){|v,o| o[v]+=1}
    @category_name = @category_name.sort do |a, b|
      b[1] <=> a[1]
    end
    @categories = @category_name.to_h
    @category_name = @category_name.to_h.first(3).to_h

    #@categories = Category.joins(:templates).select("categories.name").where("templates.scope =1").distinct

  end



  def new
    @template=Template.new
	@template.questions.build
    @category=Category.new
    @submit='作成'
    @parents_template_id = params[:id]
    if @parents_template_id
      parents_template = Template.find(@parents_template_id)
      if parents_template.scope == 1
         @parents_template = parents_template
         @parents_questions = @parents_template.questions.order(:id)
      end
    end
  end

  def show
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)
    @questions=@template.questions.order(:id)
    @document = Document.new
    @parent_tamplates= find_parent_templates(@template,[@template])
  end

  def create
    @category=Category.new(category_params)
    @template=Template.new(template_params)
    @template.scope = 0
    if @category.save
      @template.category_id = @category.id
      if @template.save #templateの保存とバリデーションチェック
        redirect_to @template
      else
        @category.destroy
        render :new
        # redirect_to new_template_path, alert: "アシスタントのタイトル、概要、カテゴリ全てを入力してください。"
      end
    else
      if @template.save #バリデーションチェック用
        @template.destroy
      end
      render :new
      # redirect_to new_template_path, alert: "アシスタントのタイトル、概要、カテゴリ全てを入力してください。"
    end
  end

  def edit
    @template=Template.find(params[:id])
    @category=Category.find(@template.category.id)
	@questions=@template.questions.order(:id)
    @submit='更新'
  end

  def update
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)

    @questions=@template.questions.order(:id)
    @document=Document.new

    if @category.update_attributes(category_params)
      if @template.update_attributes(template_params)
        redirect_to template_path
      else
        render :edit
        # redirect_to edit_template_path, alert: "アシスタントのタイトル、概要、カテゴリ全てを入力してください。"
      end
    else
      render :edit
      # redirect_to edit_template_path, alert: "アシスタントのタイトル、概要、カテゴリ全てを入力してください。"
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

  def category_auto_complete
    categories = Category.select(:name).where("name like '%" + params[:term] + "%'").order(:name)
    categories = categories.map(&:name)
    render json: categories.to_json
  end

  def template_auto_complete
    templates = Template.where(scope: 1).select(:title).where("title like '%" + params[:term] + "%'").order(:title)
    templates = templates.map(&:title)
    render json: templates.to_json
  end

  private

    def template_params
        params.require(:template).permit(:title,:topic,:category_id,:picture,:parent_template_id,questions_attributes: [:id, :qtext, :qdetail, :example, :_destroy]).merge(user_id: current_user.id)
    end
	
	def question_params
        params.require(:question).permit(:qtext, :qdetail, :example)
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

    #再帰で歴代親テンプレートをとってくる。
    def find_parent_templates(template,array)
      if template.parent_template_id
        parent_template = Template.find(template.parent_template_id)
        array.unshift(parent_template)
        find_parent_templates(parent_template,array)
      else
        return array
      end
    end

end
