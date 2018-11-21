class TemplatesController < ApplicationController
  def index
    @template=Template.all
  end

  def new
    @template=Template.new
  end

  def create
    @template=Template.new(template_params)
    if @template.save
      redirect_to templates_path
    else
      render 'new'
    end
  end

  private
  def template_params
    params.require(:template).permit(:title, :user_id, :category_id, questions_attributes: [:qtext, :qdetail, :example, :_destroy] )
  end
end
