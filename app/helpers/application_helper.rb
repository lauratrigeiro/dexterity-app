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


end