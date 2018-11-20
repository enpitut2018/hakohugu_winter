class NotesController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(update_params)
  end

   private

    def update_params
      params.require(:note).permit(:content)
    end
end
