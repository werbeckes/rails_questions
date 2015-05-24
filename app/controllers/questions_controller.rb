class QuestionsController < ApplicationController

  def new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to home_path
    else
      render 'new'
    end
  end

  def show
    @question = Question.find_by_id(params[:id])
    @answers = @question.answers
  end

  def edit
    @question = Question.find_by_id(params[:id])
  end

  def update
    @question = Question.find_by_id(params[:id])

    if @question.update(question_params)
      redirect_to user_question_path(current_user, @question)
    else
      #TODO catch errors
      render 'edit'
    end
  end

  private
    def question_params
      params.require(:question).permit(:text,:answer_type)
    end
end
