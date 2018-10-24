class Api::QuestionsController < ApplicationController
  def show
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
