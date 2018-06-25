class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list , only: [:show, :edit, :update, :destroy, :list_tasks]
  before_action :set_lists, only: [:main_page, :index, :create, :update, :destroy]
  

  def main_page
    respond_to(&:html)
  end

  def index
    respond_to do |format|
      format.js { render 'list_index.js.erb' }
    end
  end

  def list_tasks
    @tasks = @list.tasks.all
    respond_to(&:js)
  end

  def show
    respond_to(&:js)
  end

  def new
    @list = List.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @list = current_user.lists.new(list_params)
    respond_to do |format|
      if @list.save
        format.js
        format.json { render :show, status: :created, location: @list }
      else
        set_flash_error(@list)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.js
        format.json { render :show, status: :ok, location: @list }
      else
        set_flash_error(@list)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      # format.html { redirect_to root_path, notice: 'List was successfully deleted.' }
      format.js # { render 'list_index.js.erb' }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    def set_lists
      @lists = current_user.lists.all
    end

    def list_params
      params.require(:list).permit(:title, :user_id)
    end
end
