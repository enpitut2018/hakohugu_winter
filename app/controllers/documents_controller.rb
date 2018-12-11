class DocumentsController < ApplicationController
  def index
    @user = User.find(1)
    @documents = @user.documents.all
  end

  def new
    @document = Document.new
    @templates = Template.all
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to "/documents/#{@document.id}"
    else
      render 'new'
    end

  end

  def show
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(update_params)
  end

  def destroy
    if Document.find(params[:id]).destroy
      redirect_to documents_path
    else
      redirect_to documents_path
    end

  end

   private

    def update_params
      params.require(:document).permit(:content)
    end

    def document_params
      params.require(:document).permit(:title,:user_id,:template_id)
    end
end
