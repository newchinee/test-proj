class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :sort_column, :sort_direction
  
  def authenticate_any!
      if admin_user_signed_in?
          true
      else
          authenticate_user!
      end
  end
  
  def correct_user
    if admin_user_signed_in?
        true
    else
        user = User.find_by_id(params[:id])
        redirect_to root_path unless (current_user == user)
    end
  end
  
  def sort_column(model, default = "")
    model.sortable_columns.include?(params[:sort]) ? params[:sort] : default
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
