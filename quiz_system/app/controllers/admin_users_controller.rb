class AdminUsersController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def index
    @admin_users = AdminUser.search(params[:search]).order(sort_column(AdminUser, "first_name") + " " + sort_direction).paginate(page: params[:page])
  end
  
  def show
    @admin_user = AdminUser.find_by_id(params[:id])
    if @admin_user.nil? 
      redirect_to admin_users_path
    end
  end
  
  def new
    @admin_user = AdminUser.new
  end
  
  def create
    @admin_user = AdminUser.new(params[:admin_user])

    if params[:admin_user][:password].blank?
      params[:admin_user].delete(:password)
      params[:admin_user].delete(:password_confirmation)
    end
    
    if @admin_user.save
      flash[:success] = "Admin Added."
      redirect_to admin_users_path
    else
      render 'new'
    end
  end
  
  def edit
    @admin_user = AdminUser.find_by_id(params[:id])
    if @admin_user.nil? 
      redirect_to admin_users_path
    end
  end
  
  def update
    @admin_user = AdminUser.find_by_id(params[:id])
    if @admin_user.nil? 
      redirect_to admin_users_path
    else
      if params[:admin_user][:password].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end
      
      if @admin_user.update_attributes(params[:admin_user])
        flash[:success] = "Admin updated."
        redirect_to admin_users_path
      else
        render 'edit'
      end
    end
  end
  
  def destroy
    @admin_user = AdminUser.find_by_id(params[:id])
    if !@admin_user.nil?
      @admin_user.destroy
      flash[:success] = "Admin deleted."
    end

    redirect_to admin_users_path
  end
end
