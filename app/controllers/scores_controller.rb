class ScoresController < ApplicationController
	# respond_to :html, :js

	def create
		@score = current_user.scores.create(score_params)
		if @score.save
			if @score.course != 3
				@refresh = false
				@personal_best_with_settings = current_user.personal_best(course: @score.course, pointer: @score.pointer,
															 hand: @score.hand)
				@record = @score.time <= @personal_best_with_settings.time
				if session[:hand] != @score.hand || session[:pointer] != @score.pointer
					session[:hand] = @score.hand
					session[:pointer] = @score.pointer
					@refresh = true
				end
				if @record || @refresh
					@overall_best = Score.overall_best(course: @score.course)
					@overall_best_with_settings = Score.overall_best(course: @score.course, pointer: @score.pointer,
															 hand: @score.hand)
					@personal_best = current_user.personal_best(course: @score.course)
					@refresh = true
				end
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

	def update
		@score = Score.find(params[:id])
		@score.update(time: params[:score][:time])
		if @score.save
			respond_to do |format|
			  format.html do
			  	flash[:error] = 
					"Please enable JavaScript to play this course." 
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
		@course = request.path[-1].to_i
		redirect_to root_url and return if !(1..3).include?(@course)
	end

	def refresh_best	
		@overall_best = Score.overall_best(course: params[:course])
		@overall_best_with_settings = Score.overall_best(course: params[:course], pointer: params[:new_pointer],
														 hand: params[:new_hand])
		@personal_best = current_user.personal_best(course: params[:course])
		@personal_best_with_settings = current_user.personal_best(course: params[:course], pointer: params[:new_pointer],
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
		show_values = ["10", "25", "All"]
		course = params[:course] || "1"
		column = params[:column] || ""
		filter = params[:filter] || ""
		redirect_to root_url and return if column.length > 0 && (!Score.column_names.include?(column) || 
													  (!Score.uniq.pluck(column).map(&:to_s).include?(filter) && filter != "all"))

		redirect_to root_url and return if !values.include?(course)
		redirect_to root_url and return if !show_values.include?(@show_number)
		if course == "3" && !current_user.played_course_3?
			@course_3_error = true
		 	flash[:danger] = 
		 			"You must play Course 3 at least once to view top scores."
		else
			@course_3_error = false
			direction = course == "3" ? :desc : :asc
			if @show_number == "All"
				if column == "" || filter == "all"
					@scores = @scores.where(course: course).order(time: direction)
				else
					@scores = @scores.where(course: course, column => filter).order(time: direction)
				end
			else 
				if column == "" || filter == "all"
					@scores = @scores.where(course: course).order(time: direction).limit(@show_number.to_i)
				else
					@scores = @scores.where(course: course, column => filter).order(time: direction).limit(@show_number.to_i)
				end	
			end
			if filter.length > 0
				@filter_select = filter
			else
				@filter_select = "all"
			end
		end
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
