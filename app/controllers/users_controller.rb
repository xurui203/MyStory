class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show 
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	
  	if @user.save
  		#handle successful
      sign_in @user
      flash[:success] = "Start writing your story!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  private 
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
