module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		base_title = "Dexterity App"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
	
	# Correctly prints a time read from the database
	def display_time(db_time, course = 1)
		course == 3 ? db_time : '%.3f' % (db_time / 1000.0).to_s
	end

	# Prints a 'best' time appropriately.
	def print_best_time(scope, opts = {})
		return "Error" if (scope != 'overall' && scope != 'personal') || opts.empty?
		settings_msg = if opts.length > 1
						" with #{opts[:pointer]} and #{opts[:hand]} hand"
					   else
					   	""
					   end
		if opts.has_key?(:score)
			score = opts[:score]
		else
			score = if scope == 'overall'
						Score.overall_best(opts)
			      	else
						current_user.personal_best(opts)
			      	end
		end
		if score
			"#{scope.capitalize} best time#{settings_msg}: #{display_time(score.time)} seconds"
		else
			"No #{scope} times#{settings_msg}"
		end
	end

	# Sorts a table by the assigned column
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = (column == sort_column) ? 
					"current #{sort_direction}" : nil
		direction = (column == sort_column && 
				sort_direction == "asc" ) ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction},
						{:class => css_class}
	end

	# Filters a table by the assigned column's attribute
	def filter(column, filter)
		title ||= filter.titleize
		link_to title, :column => column, :filter => filter
	end

	# Creates a select options list for a column
	def make_select(column)
		form_for(:users, url: user_path, id: "select-form", method: :get) do |f| 
			column_values = Score.uniq.pluck(column)
			label = "#{column}_select" 
			f.label :label
			pre_select = if params[:column] == column
							session[:filter] || column_values
						else
							column_values
						end
			f.select(label, options_for_select(column_values.map { |value| [ value, value ] }, pre_select), { :include_blank => false}, { :multiple => true, :size => column_values.length })
 
		end
	end


end