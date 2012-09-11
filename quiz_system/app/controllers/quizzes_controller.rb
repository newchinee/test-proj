class QuizzesController < ApplicationController
  before_filter :authenticate_admin_user!, :except => [:show]
  
  # GET /quizzes
  def index
    # @quizzes = Quiz.where(:deleted_flag => false)
    @quizzes = Quiz.joins(:category).search(params[:search]).order(sort_column(Quiz, "name") + " " + sort_direction).paginate(page: params[:page])
  end

  # GET /quizzes/1
  def show
    @quiz = Quiz.find(params[:id]) 
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    @method = 'new'
     # 2.times do
       # question = @quiz.questions.build
       # 4.times { question.answers.build }
     # end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    @method = 'update'
  end

  # POST /quizzes
  def create
    @quiz = Quiz.new(params[:quiz])
    @quiz.update_time_allowed(params[:hours_allowed].to_i, params[:minutes_allowed].to_i)

    if @quiz.save
      @quiz.update_answer_score
      @quiz.update_completeness
      redirect_to @quiz, notice: 'Quiz was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /quizzes/1
  def update
    @quiz = Quiz.find(params[:id])
    @quiz.update_time_allowed(params[:hours_allowed].to_i, params[:minutes_allowed].to_i)

    if @quiz.update_attributes(params[:quiz])
      @quiz.update_answer_score
      @quiz.update_completeness
      redirect_to @quiz, notice: 'Quiz was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /quizzes/1
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    redirect_to quizzes_url
  end
end
