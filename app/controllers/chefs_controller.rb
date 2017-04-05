class ChefsController < ApplicationController
  
  def new
    @chef = Chef.new
  end
  
  def create
    # debugger # used to debug. Can see params, and then continue<
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome! #{ @chef.chefname } to My Recipes App!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end
  
  def show
    
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
end