class TemplatesController < ApplicationController
  def index
    @templates=Template.all
    @user = User.find(1)
    @my_templates=@user.templates
  end

  def new
    @template=Template.new
    @submit='作成'
  end

  def show
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)
    @questions=Question.where(template_id: @template.id)
  end

  def create
    @template=Template.new(template_params)
    @template.save
    redirect_to templates_path
  end

  def edit
    @template=Template.find(params[:id])
    @submit='更新'
  end

  def update
    @template=Template.find(params[:id])
    @category=Category.find(@template.category_id)
    @questions=Question.where(template_id: @template.id)
    if @template.update_attributes(template_params)
      render 'show'
    else
      render 'edit'
    end
  end

  def destroy
    if Template.find(params[:id]).destroy
      redirect_to templates_path
    else
      render 'show'
    end
  end

  private
  def template_params
    params.require(:template).permit(:title,:topic,:user_id,:category_id,questions_attributes: [:id, :qtext, :qdetail, :example, :_destroy])
  end
end
