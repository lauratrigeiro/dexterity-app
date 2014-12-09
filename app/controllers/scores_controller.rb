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

	def refresh_best
		@overall_best = Score.overall_best(course: 1)
		@overall_best_with_settings = Score.overall_best(course: 1, pointer: params[:new_pointer],
														 hand: params[:new_hand])
		@personal_best = current_user.personal_best(course: 1)
		@personal_best_with_settings = current_user.personal_best(course: 1, pointer: params[:new_pointer],
														 hand: params[:new_hand])
		respond_to do |format|
			format.html 
			format.js
		end
	end

	private

	def score_params
		params.require(:score).permit(:time, :course, :pointer, :hand)
	end
end
