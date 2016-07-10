class WikisController < ApplicationController
  
  before_action :find_wiki, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
  
  def index
		if params[:category].blank?
			@wikis = Wiki.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@wikis = Wiki.where(category_id: @category_id).order("created_at DESC")
		end
  end
  
  def show
    @wikis = Wiki.find(params[:id])
  end

  def new
    @wiki = current_user.wikis.build
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    #authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was saved"
        redirect_to @wiki
    else
      flash[:error] = "There was an error saving your wiki.  Please try again"
        render 'new'
    end
  end
  
  def edit
  end
  
  def update
		if @wiki.update(wiki_params)
			redirect_to @wiki
		else
			render 'edit'
		end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    #authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private
  
  def find_wiki
	  @wiki = Wiki.find(params[:id])
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :content, :category_id, :private)
  end
end