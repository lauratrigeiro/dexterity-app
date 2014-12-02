class UsersController < ApplicationController
  
  helper_method :sort_column, :sort_direction, :filter_column

  def show
  	@user = User.find(params[:id])
  	@unordered_scores = filter_column
  	@unordered_scores ||= @user.scores
  	@scores = @unordered_scores.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])
    @values = params["users[pointer_select][]"] || "boo"

  end

  def index
  	# @users = User.paginate(page: params[:page])
  	@users = User.all
  end

  private

  def sort_column
	Score.column_names.include?(params[:sort]) ? params[:sort] : "time"
	# The following line works but is open to SQL injection.
  #  params[:sort] || "time"
  end
  
  def sort_direction
  	# %w[asc desc] is equiv. to ["asc", "desc"]
    %w[asc desc].include?(params[:direction]) ?  
    			params[:direction] : "asc"
 	# The following line works, but is open to SQL injection.
 #   params[:direction] || "asc"
  end

  def filter_column
  #	column = params[:column] 
    params[:column] ||= session[:column]
    session[:column] = params[:column]
  #	filter = params[:filter]
    params[:filter] ||= session[:filter]
    session[:filter] = params[:filter]
   	values = Score.uniq.pluck(params[:column]).map(&:to_s) if params[:column]
  	if Score.column_names.include?(params[:column]) && values.include?(params[:filter])
   		@user.scores.where("#{params[:column]} = #{params[:filter]}")
  	else
  		nil
  	end
  end

end
