class ListsController < ApplicationController
  # before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_list, only: [:show]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to(root_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  # end

  # def update
  #   @list = list.update(list_params)
  #   if @list.save
  #     redirect_to(list_path(@list))
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @list.destroy
  #   redirect_to(root_path)
  # end

  private

  def list_params
    params.require(:list).permit(:name, :image_url)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
