class Api::QuestionsController < ApplicationController
  before_action :correct_user,   only: [:show]
   def show
     document_id = params[:document_id]
     @document = Document.find(document_id)
     template_id = @document.template_id
     @template = Template.find(template_id)
     @questions = @template.questions.order(:id)
     @template.picture? ? @image_path1 = view_context.cl_image_path(@template.picture) : @image_path1 = view_context.image_path('hakohugu 200X200.png')
     @user = @document.user
     @user.picture? ? @image_path2 = view_context.cl_image_path(@user.picture) : @image_path2 = view_context.image_path('hakohugu2 200X200.png')
     render 'show', formats: 'json', handlers: 'jbuilder'
   end

   private
    def correct_user
      document_id = params[:document_id]
      document = Document.find(document_id)
      user_id = document.user_id
      redirect_to('/') if user_id != session[:user_id]
    end
end


