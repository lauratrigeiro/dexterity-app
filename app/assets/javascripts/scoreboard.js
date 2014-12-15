$(".users.show").ready(function() {
	$('#users_pointer_select').multiselect({
		//  includeSelectAllOption: true,
		//  allSelectedText: 'No option left ...'
	//	 selectAllValue: 'select-all-value'

		 onDropdownHide: function(event) {
			$('#users_pointer_select').closest('form').trigger('submit');
			}
	});
//	$('#pointer-select').multiselect('select', 'mouse'); 
	$('#users_hand_select').multiselect({
	//	  includeSelectAllOption: true,
		//  allSelectedText: 'No option left ...'
	//	 selectAllValue: 'select-all-value'
	});
});

$(".scores.index").ready(function() {

	$('#show').change(function() {
		$('#show-number').submit();
	});

	$(".course-btns .btn").click(function() {	
		if(!$(this).hasClass("active")) {
			$(".course-btns .active input").prop('checked', false);
			$(".course-btns .active").removeClass("active");
			$(this).addClass("active");
			$(".course-btns .active input").prop('checked', true);
			$('#show-number').submit();
		}
	});

	$('#leaderboard-table').on('change', '.filter-select', function() {
		$('#column').val(this.name);
		$('#filter').val($(this).val());
		$('#show-number').submit();
	});

});
	

