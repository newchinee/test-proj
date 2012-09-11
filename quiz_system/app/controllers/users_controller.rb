class UsersController < ApplicationController
  before_filter :authenticate_admin_user!, :except => [:show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.search(params[:search]).order(sort_column(User, "first_name") + " " + sort_direction).paginate(page: params[:page])
  end
  
  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      changePage
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.save
      flash[:success] = "User Added."
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    if @user.nil? 
      changePage
    end
  end
  
  def update
    @user = User.find_by_id(params[:id])
    if @user.nil? 
      changePage
    else
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      
      if @user.update_attributes(params[:user])
        flash[:success] = "User Updated."
        changePage
      else
        render 'edit'
      end
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    if !@user.nil?
      @user.destroy
      flash[:success] = "User deleted."
    end

    redirect_to users_path
  end
  
  private
    def changePage
      if admin_user_signed_in?
        redirect_to users_path
      else
        redirect_to root_path
      end
    end
end
