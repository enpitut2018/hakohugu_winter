class TemplatesController < ApplicationController
  def index
  end

  def new
    @template=Template.new
  end

  def create
    @template=Template.new(template_params)
  end

  private
  def template_params
    params.require(:template).permit(:title, questions_attributes: [:qtext, :qdetail, :example, :_destroy] )
  end
end
