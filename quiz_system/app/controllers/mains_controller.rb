class MainsController < ApplicationController
  before_filter :authenticate_user!
   
  def quizaction
    result = Result.find(params[:id])
    
    if(params[:task] == "continue")
      offset = UserAnswer.count(
        :all,
        :conditions => ["user_id = ? and quiz_id = ? and completed_flag = ?", current_user.id, result.quiz.id, false]
      )
      redirect_to "/mains/quiz/#{result.quiz.id}?offset=#{offset}"    
    else
      redirect_to "/mains/quiz/#{result.quiz.id}"
    end
  end
  
  def show
    @categories = Category.find(:all)    
  end
  
  def index
    @categories = Category.find(:all)
  end
  
  def category
    @quizzes = Quiz.find_completed_quiz_by_category(params[:id])  
  end
  
  def pause
    @quiz = Quiz.find_by_id(params[:id])
    if !@quiz.nil? 
      @result = Result.find_by_user_id_and_quiz_id(current_user.id, params[:id])
      if !@result.blank?
        @result.time_taken += (Time.now - @result.resume_time)
        @result.status = Result::STATUS_PAUSE
        @result.save
      end
    end
    
    redirect_to mains_quiz_path
  end
  
  def quiz
    @quiz_id = params[:id]
    @offset = 0
    @submit = 'Next'
    
    @quiz = Quiz.find_by_id(@quiz_id)
    if @quiz.nil? 
      redirect_to mains_quiz_path
    end
    
    @prev_session = 'prev_' + session['session_id']
    UserAnswer.update_all ['session_id = ?', @prev_session], ["user_id = ? and quiz_id = ? and completed_flag = ?", current_user.id, @quiz_id, true]
    
    @result = Result.find_by_user_id_and_quiz_id(current_user.id, @quiz_id)
    if !@result.blank?
      if @result.status == Result::STATUS_PAUSE
        @result.resume_time = Time.now
        @result.status = Result::STATUS_RESUME
        @result.save
      end
    end
    
    if !params[:offset].blank?
      @offset = params[:offset]
    else     
      if @result.blank?
        @result = Result.new
        @result.user_id = current_user.id
        @result.quiz_id = @quiz_id
        @result.start_time = Time.now
        @result.resume_time = @result.start_time
        @result.marks = 0
      else
        @result.retry_count += 1
        @result.start_time = Time.now
        @result.resume_time = @result.start_time
        @result.end_time = nil
        @result.time_taken = 0
        @result.marks = 0
        UserAnswer.delete_all(["user_id = ? and quiz_id = ?", current_user.id, @quiz_id])
      end
      
      @result.save
      
      if @result.status == Result::STATUS_STARTED
        @time_left = (Time.now + @quiz.time_allowed.minutes) - @result.start_time
      else
        @time_left = (Time.now + (@quiz.time_allowed.minutes - @result.time_taken)) - @result.start_time
      end
      
      @time_left = 0 if @time_left < 0
    end
    
    if !params[:time_left].blank?
      @time_left = params[:time_left]
    end
    
    @next = @offset.to_i + 1
    
    @no_question = Question.count(
      :all,
      :conditions => ["quiz_id = ? and deleted_flag = ?", @quiz_id, false]
    )
    
    if @next == @no_question
      @action = '/mains/result'
      @submit = 'Score'
    end
    
    if @no_question > 0
      @questions = Question.find(
        :all,
        :conditions => ["quiz_id = ? and deleted_flag = ?", params[:id], false],
        :order => 'id',
        :limit => 1,
        :offset => @offset
      )    
       
      @questions.each do |question|
        @answers = Answer.find_all_by_question_id(question.id)
      end
      
      @answers.each do |answer|
        if answer.correct_flag == true
          @correct_answer = answer.name
          @correct_explanation = answer.explanation
        end
      end
    end
  end
  
  def result
      @score = 0
      @total_score = 0
      @quiz_id = params[:quiz_id]
      
      @no_question = Question.count(
        :all,
        :conditions => ["quiz_id = ? and deleted_flag = ?", @quiz_id, false]
      )

      @prev_session = 'prev_' + session['session_id']
      UserAnswer.delete_all(["user_id = ? and quiz_id = ? and session_id = ? and completed_flag = ?", current_user.id, @quiz_id, @prev_session, true])
      
      @no_answer = UserAnswer.count(
        :all,
        :conditions => ["user_id = ? and quiz_id = ? and session_id = ?", current_user.id, @quiz_id, session['session_id']]
      )
      
      if @no_question == @no_answer
        @user_answers = UserAnswer.find(
          :all,
          :conditions => ["user_id = ? and quiz_id = ? and session_id = ?", current_user.id, @quiz_id, session['session_id']]
        )
        
        @user_answers.each do |user_answer|
          user_answer.update_attribute(:completed_flag, true)
          @answer = Answer.find_by_id(user_answer.answer_id)
          @score += @answer.score;
        end
        
        @questions = Question.find(
          :all,
          :conditions => ["quiz_id = ? and deleted_flag = ?", @quiz_id, false],
        )    
         
        @questions.each do |question|
          @answers = Answer.find(
            :all,
            :conditions => ["question_id = ? and correct_flag = ?", question.id, true],
          )
          
          @answers.each do |answer|
            @total_score += answer.score
          end
        end
        
        @marks = (@score / @total_score.to_f) * 100
        @marks = @marks.round
        @result = Result.find_by_user_id_and_quiz_id(current_user.id, @quiz_id)
        @result.status = Result::STATUS_ENDED
        @result.end_time = Time.now
        @result.time_taken = @result.time_taken + (@result.end_time - @result.resume_time)
        @result.marks = @marks
        @result.save
      end
  end
end