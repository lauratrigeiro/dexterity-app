class ScoresController < ApplicationController

	def create
		@score = current_user.scores.create(score_params)
		if @score.save
			flash[:success] = "Score created!"
			redirect_to '/scores/new'
		else
			render 'static_pages/home'
		end
	end

	def new
		@score = Score.new
	end

	private

	def score_params
		params.require(:score).permit(:time, :course, :pointer, :hand)
	end
end
