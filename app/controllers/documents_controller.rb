class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_list

  rescue_from ActionController::ParameterMissing, with: :empty_document_error

  def index
    @documents = @list.documents.all
  end

  def show; end

  def new
    @document = Document.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @document = @list.documents.new(document_params)
    respond_to do |format|  
      if @document.save
        format.js
        format.json { render :show, status: :created, location: @document }
      else
        set_flash_error(@document)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @document.assign_attributes(document_params)
    @document.timezone = @client_timezone
    respond_to do |format|
      if @document.save
        format.js
        format.json { render :show, status: :ok, location: @document }
      else
        set_flash_error(@document)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      # format.html { redirect_to root_path, notice: 'Document was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

    def set_document
      @document = Document.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def document_params
      params.require(:document).permit(:file, :list_id)
    end

    def empty_document_error
      flash[:alert] = "Document must exist!"
      respond_to do |format|
        format.js { render 'shared/notice.js.erb' }
      end
    end
end