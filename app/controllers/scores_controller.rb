class ScoresController < ApplicationController
	# respond_to :html, :js

	def create
		@score = current_user.scores.create(score_params)
		if @score.save
			@refresh = false
			@personal_best_with_settings = current_user.personal_best(course: 1, pointer: @score.pointer,
														 hand: @score.hand)
			@record = @score.time <= @personal_best_with_settings.time
			if session[:hand] != @score.hand || session[:pointer] != @score.pointer
				session[:hand] = @score.hand
				session[:pointer] = @score.pointer
				@refresh = true
			end
			if @record || @refresh
				@overall_best = Score.overall_best(course: 1)
				@overall_best_with_settings = Score.overall_best(course: 1, pointer: @score.pointer,
														 hand: @score.hand)
				@personal_best = current_user.personal_best(course: 1)
				@refresh = true
			end

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

	def index
		@scores = Score.all
		values = Score.uniq.pluck(:course).map(&:to_s)
		@show_number = params[:show] || "10"
		course = params[:course] || "1"
		puts "course: #{course}"
		if values.include?(course)
			if @show_number == "All"
				@scores = @scores.where(course: course).order(:time)
			elsif @show_number == "10" || @show_number == "25"
				@scores = @scores.where(course: course).order(:time).limit(@show_number.to_i)
			else
				redirect_to root_url
			end
			respond_to do |format|
				format.html 
				format.js
		  	end
		else
			redirect_to root_url
		end
	end

	

	private

	def score_params
		params.require(:score).permit(:time, :course, :pointer, :hand)
	end
end
