class ScoresController < ApplicationController

	def create
		@score = Score.new
		redirect_to 'new'
	end

	def new
		@score = Score.new
	end
end
