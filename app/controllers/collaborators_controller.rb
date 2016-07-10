class CollaboratorsController < ApplicationController
    
    def destroy
        @collaborator = Collaborator.find(params[:id])
    
    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user.name}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end
  
end
