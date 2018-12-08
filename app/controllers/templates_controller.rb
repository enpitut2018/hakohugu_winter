class TemplatesController < ApplicationController
  def index
    @templates=Template.all
    @user = User.find(1)
    @my_templates=@user.templates
  end

  def new
    @template=Template.new
  end

  def create
    @template=Template.new(template_params)
    @template.save
    redirect_to templates_path
  end

  private
  def template_params
    params.require(:template).permit(:title,:topic,:user_id,:category_id,questions_attributes: [:qtext, :qdetail, :example, :_destroy])
  end
end
