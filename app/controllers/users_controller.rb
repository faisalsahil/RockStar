class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]
  before_action :authenticate_user!


  def index
    # if admin?
      @users = User.all
    # else
    #   redirect_to root_url
    # end
  end


  def edit
   @user   = User.find_by_id(params[:id])
    @roles = Role.all
  end

  def update_user
    @user           = User.find_by_id(params[:id])
    @user.email     = params[:user][:email]
    @user.role_id   = params[:user][:role_id]
    if @user.save
      flash[:success] = 'User successfully updated'
      redirect_to root_url
    else
      flash[:danger] = 'User already exist'
      redirect_to :back
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def add_user
    @user = User.new(user_params)
    if params[:user][:password].present? && params[:user][:password_confirmation].present? && params[:user][:password] == params[:user][:password_confirmation]
       # password        = SecureRandom.hex(20)
      @user.email     = params[:user][:email]
      @user.password  = params[:user][:password]
      @user.password_confirmation  = params[:user][:password_confirmation]
      @user.role_id = params[:user][:role_id]
      @user.skip_confirmation!
      if @user.save
        # @user.send_reset_password_instructions
        flash[:success] = 'User successfully saved'
        redirect_to root_url
      else
        flash[:danger] = 'User already exist'
        redirect_to :back
      end
    else
      @roles = Role.all
      render 'new'
    end
  end


  def destroy
    # authorize! :delete, @user
    if @user.is_deleted == false
      @user.is_deleted = true
    else
      @user.is_deleted = false
    end
    @user.save!
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

