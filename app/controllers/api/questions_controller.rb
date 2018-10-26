class Api::QuestionsController < ApplicationController
  def show
	 template_id = params[:template_id]
	 # @questions = Template.find_by(template_id).contains
     render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
