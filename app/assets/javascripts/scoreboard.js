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

var course_number;

$(".scores.index").ready(function() {
	course_number = $('#course-number').text();
//	$('#course').val($('#course-number').text());
//	alert(course_number);
//	alert($('#course-number').val());
	$('#show').change(function() {
		$('#course').val($('#course-number').text());
	//	alert("ha");
	//	alert($(this).val());
		$('#show-number').submit();
	});

});
	

