class UsersController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  def show
  	@user = User.find(params[:id])
  	@scores = @user.scores.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])

  end

  def index
  	# @users = User.paginate(page: params[:page])
  	@users = User.all
  end

  private

  def sort_column
	Score.column_names.include?(params[:sort]) ? params[:sort] : "time"
	# The following line works but is open to SQL injection.
    params[:sort] || "time"
  end
  
  def sort_direction
  	# %w[asc desc] is equiv. to ["asc", "desc"]
    %w[asc desc].include?(params[:direction]) ?  
    			params[:direction] : "asc"
 	# The following line works, but is open to SQL injection.
 #   params[:direction] || "asc"
  end
end
