class ResultsController < ApplicationController
  before_filter :authenticate_admin_user!, :except => [:show, :index]
  before_filter :correct_user, :only => [:show]
  before_filter :authenticate_any!, :only => [:index]
    
  def index
    @filter_quiz = Array.new
    @filter_quiz << ['', -1]
    Result.joins(:quiz).select("quiz_id, quizzes.name").uniq.map do |c|
      @filter_quiz << [c.quiz.name, c.quiz_id]
    end
    
    if admin_user_signed_in?
      @filter_user = Array.new
      @filter_user << ['', -1]
      Result.joins(:user).select("user_id, users.first_name, users.last_name").uniq.map do |c|
        @filter_user << ["#{c.user.first_name} #{c.user.last_name}", c.user_id]
      end

      @results = Result.joins(:user).joins(:quiz)
                     .filter_by_quiz(params[:filter_quiz])
                     .filter_by_user(params[:filter_user])
                     .search(params[:search])
                     .order(sort_column(Result, "id") + " " + sort_direction)
                     .paginate(page: params[:page])
    else
      @results = current_user.results.joins(:user).joins(:quiz)
                     .filter_by_quiz(params[:filter_quiz])
                     .search(params[:search])
                     .order(sort_column(Result, "id") + " " + sort_direction)
                     .paginate(page: params[:page])
    end
  end

  def show
    @result = Result.joins(:user).find(params[:id])
  end

  def edit
    @result = Result.find(params[:id])
  end
  
  # def create
    # @result = Result.new(params[:result])
# 
    # respond_to do |format|
      # if @result.save
        # format.html { redirect_to @result, notice: 'Result was successfully created.' }
        # format.json { render json: @result, status: :created, location: @result }
      # else
        # format.html { redirect_to @result }
        # format.json { render json: @result.errors, status: :unprocessable_entity }
      # end
    # end
  # end

  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end
  
  private
    def correct_user
      if admin_user_signed_in?
        true
      else
        result = Result.find_by_id(params[:id])
        if result.nil?
          return false
        end
        
        user = User.find_by_id(result.user_id)
        redirect_to results_path unless (current_user == user)
      end
    end
end
