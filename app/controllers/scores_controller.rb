class ScoresController < ApplicationController
	# respond_to :html, :js

	def create
		@score = current_user.scores.create(score_params)
		if @score.save
			session[:hand] = @score.hand
			session[:pointer] = @score.pointer
			respond_to do |format|
			  format.html do
			  	flash[:success] = 
				"You finished in #{@score.time} seconds!" 
				redirect_to new_score_path 
			  end
			  format.js
			end

		else
			render 'static_pages/home'
		end
	end

	def new
		@score = Score.new
	#	@session_hand = session[:hand] || "right"
	end

	private

	def score_params
		params.require(:score).permit(:time, :course, :pointer, :hand)
	end
end
