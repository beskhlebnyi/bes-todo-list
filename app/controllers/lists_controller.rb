class ListsController < ApplicationController
  before_action :set_list , only: [:show, :edit, :update, :destroy]
  before_action :set_lists, only: [:index, :create, :update]

  # GET /lists
  # GET /lists.json
  def index; end

  # GET /lists/1
  # GET /lists/1.json
  def show
    respond_to(&:js)
  end

  # GET /lists/new
  def new
    @list = List.new
    respond_to(&:js)
  end

  # GET /lists/1/edit
  def edit
    respond_to(&:js)
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to root_path, remote: true, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { redirect_to root_path, notice: "Title can't be blank" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to root_path, remote: true, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :update }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'List was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    def set_lists
      @lists = List.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title)
    end
end
