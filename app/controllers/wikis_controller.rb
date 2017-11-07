class WikisController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @wikis = policy_scope(Wiki)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saves successfully."
    else
      flash.now[:alert] = "Error creating Wiki. Please try again."
    end
    render :show
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting this Wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
