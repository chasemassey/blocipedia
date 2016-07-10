class UsersController < ApplicationController
    

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def downgrade
    @user = current_user
    @wikis = @user.wikis
    if current_user.update(role: 'standard')
      public_uncheck if current_user.role == 'standard'
      flash[:notice] = "Account downgraded successfully."
    else  
      flash[:error] = "There was an error. Please try again."
    end
    redirect_to edit_user_registration_path
  end
  
  private 

  
  def public_uncheck
    Wiki.where(user_id: current_user.id).where(public: false).update_all(public: true)
  end
end
