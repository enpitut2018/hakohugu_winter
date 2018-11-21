class Api::QuestionsController < ApplicationController
   def show
     document_id = params[:document_id]
     @document = Document.find(document_id)
     template_id = @document.template_id
     @template = Template.find(template_id)
     @questions = @template.questions
     render 'show', formats: 'json', handlers: 'jbuilder'
   end
end
