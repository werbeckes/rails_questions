class QuestionsController < ApplicationController

  def new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to home_path
    else
      render 'new'
    end
  end
end
