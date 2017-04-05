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
    @chef = Chef.find(params[:id])
  end
  
  def edit
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])  
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def index
    @chefs = Chef.all
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
end