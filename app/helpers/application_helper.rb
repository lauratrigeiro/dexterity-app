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
		form_for(:users, url: users_show_path) do |f| 
			column_values = Score.uniq.pluck(column)
			label = "#{column}_select" 
			f.label :label
			f.select("pointer_select", options_for_select(column_values.map { |value| [ value, value ] }, "mouse"), { :include_blank => false}, { :multiple => true, :size => column_values.length })
		#	f.submit 
		end
	end


end