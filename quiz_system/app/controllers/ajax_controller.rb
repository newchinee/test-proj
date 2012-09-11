class AjaxController < ApplicationController
  def getanswer
    @user_answer = params[:user_answer]
    @question = Question.find_by_id(params[:question_id])
    if(@question)
        @answers = Answer.find(
          :all,
          :conditions => ["question_id = ? and correct_flag = ?", @question.id, true],
          :limit => 1
        )
        
        @answers.each do |answer|
            @answer = answer.id
            @name = answer.name
            @explanation = answer.explanation
        end
        
        if(@user_answer)
          @exist_answer = UserAnswer.count(
            :all,
            :conditions => ["user_id = ? and question_id = ? and session_id = ? and completed_flag = ?", current_user.id, @question.id, session['session_id'], false]
          )
          
          if @exist_answer == 0
            user_answer = UserAnswer.new
            user_answer.user_id = current_user.id
            user_answer.quiz_id = @question.quiz_id
            user_answer.question_id = @question.id
            user_answer.answer_id = @user_answer
            user_answer.session_id = session['session_id']
            user_answer.completed_flag = false
            user_answer.save
          end
        end
    end
    
    render :json => {:answer => @answer, :explanation => @explanation}.to_json
  end
  
  def getselectedanswer
    @question_id = params[:question_id]
    @user_answers = UserAnswer.find(
      :all,
      :conditions => ["user_id = ? and question_id = ? and session_id = ? and completed_flag = ?", current_user.id, @question_id, session['session_id'], false],
      :limit => 1
    )
    @user_answers.each do |user_answer|
        @selected_answer = user_answer.answer_id
    end
    
    render :json => {:selected_answer => @selected_answer}.to_json
  end
end
