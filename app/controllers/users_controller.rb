class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]

  helper_method :sort_column, :sort_direction, :filter_column

  def show
  	@user = User.find(params[:id])
  	@unordered_scores = filter_column
  	@unordered_scores ||= @user.scores
  	@scores = @unordered_scores.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])
  end

  def index
  	# @users = User.paginate(page: params[:page])
  	@users = User.all
  end

  private
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
  end

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
    if params[:users]
      params[:users][:pointer_select] = params[:users][:pointer_select].delete_if{ |x| x.empty? }
      params[:column] = "pointer"
      params[:filter] = params[:users][:pointer_select]
  end
    params[:column] ||= session[:column]
    session[:column] = params[:column]
  #	filter = params[:filter]
    params[:filter] ||= session[:filter]
    session[:filter] = params[:filter]
   	values = Score.uniq.pluck(params[:column]).map(&:to_s) if params[:column]
  	if Score.column_names.include?(params[:column]) && (
      (params[:filter].class == Array && values.to_set.intersect?(params[:filter].to_set)) ||
          (params[:filter].class != Array && values.include?(params[:filter])))
     		@user.scores.where({params[:column] => params[:filter]})
  	else
  		nil
  	end
  end

end
