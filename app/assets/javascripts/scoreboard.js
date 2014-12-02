$(".users.show").ready(function() {
	$('#users_pointer_select').multiselect({
		  includeSelectAllOption: true,
		  selectAllValue: 'select-all-value',
 		  allSelectedText: 'No option left ...'
	});
//	$('#pointer-select').multiselect('select', 'mouse');
});
	

