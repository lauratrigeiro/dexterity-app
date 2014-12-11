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
	

