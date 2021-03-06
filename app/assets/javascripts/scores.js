var leftClicks = 0;
var rightClicks = 0;
var startTime;
var count = 1;
var nextId;
var course_3_count;

$(".scores.new").ready(function() {

	// correcting course 2 early stopping leads to course 1 start btn being disabled after stopping early
	$("#start-btn").prop('disabled', false);

	// User chooses pointer setting
	$(".pointer-btns .btn").click(function() {	
		if(!$(this).hasClass("active")) {
			$(".pointer-btns .active").removeClass("active");
			$(this).addClass("active");
		}
	});
	// User chooses hand setting
	$(".hand-btns .btn").click(function() {	
		if(!$(this).hasClass("active")) {
			$(".hand-btns .active").removeClass("active");
			$(this).addClass("active");
		}
	});

	$("#refresh-btn").click(function() {
		$("#new-pointer").val($.trim($(".pointer-btns .active").text()));
		$("#new-hand").val($.trim($(".hand-btns .active").text()));
	});

	// Start game
	$("#start-btn").click(function(){
		course_3_count = 0
		$(this).hide();
		$("#selections").hide();
		$("#scroll-down").hide();
		setupGame($("#course").val());
		$(".game-btn").show();
		startTime = +new Date();	
	});
	
	if($("#course").val() == 1) {
		$("#left-btn").click(function(){
			leftClicks++;
			$("#right-btn").prop('disabled', false);
			$("#left-btn").prop('disabled', true);
		});

		$("#right-btn").click(function(){
			rightClicks++;
			// Game is complete, show 'Done' button
			if(leftClicks == 5 && rightClicks == 5) {
				$(".game-btn").hide();
				$("#done-btn").show();
				 $("#done-btn").click(function(){
				 	onDone();
					resetGame();
				});
			}
			else {
			$("#right-btn").prop('disabled', true);
			$("#left-btn").prop('disabled', false);
			}
		});
	}

	else if($("#course").val() == 2) {
		$("#course-btns").on('click', '.next-btn', (function() {
			$(this).prop('disabled', true);
			$(this).removeClass('next-btn');
			count++;
			if(count > 10) {
				nextId = "1";
				$(".game-btn").hide();
				$("#done-btn").show();
				 $("#done-btn").click(function(){
				 	onDone();
					resetGame();
				});
			}
			else if(count == 10) {
				nextId = "5";
			}
			else if(count > 5) {
				nextId = (10-count).toString();
			}
			else {
				nextId = count.toString();
			}
		//	console.log("next id: " + "#btn-"+nextId);
			$('#btn-'+nextId).addClass('next-btn');
			$('#btn-'+nextId).prop('disabled', false);
		}));
	}

	else if($("#course").val() == 3) {
			$("#buttons").on('click', '#done-btn', (function(){
			// 	method to find absolute location of an object
			//	var rect = $(".directions").get(0).getBoundingClientRect();
			//	console.log(rect.top, rect.right, rect.bottom, rect.left);
				course_3_count += 1;
				console.log("Are we getting here? " + course_3_count);
				// if(course_3_count == 2) {
				// 	$("#done-form").attr("method", "patch");
				// 	console.log("patch now?");
				// }
			 	onDone();

				// The following works in browsers except for Firefox, 
				// so had to be abandoned.
			 	// window.onbeforeunload = function(){ 
					// alert("Course 3 Explanation!");
			 	// 	return 'The thing about Course 3...';
			 	//	});
			}));
	}

	else {
		alert("Not a valid course!");
	}
});

function setupGame(course) {
	if (course == 1) {
		$("#right-btn").prop('disabled', true);
		$("#left-btn").prop('disabled', false);
	}
	else if (course == 2) {
		if ($("#btn-1").prop('disabled') == true) {
			$("#course-btns .game-btn:enabled").removeClass('next-btn');
			$("#course-btns .game-btn:enabled").prop('disabled', true);
			$('#btn-1').addClass('next-btn');
			$('#btn-1').prop('disabled', false);
		}
	 }
	else if(course == 3) {
			$("#done-btn").addClass("course-3-btn");
			$("#done-btn").show();
	//		Turbolinks.pagesCached(0);
	//		alert("turbolink cache: " + Turbolinks.pagesCached());
	}
	else {
		alert("That is not a course!");
	}
}

function onDone() {
	// Game is done, calculate time and remember game settings
	if(course_3_count > 0) {
		$("#score-time").val(course_3_count);
		// if(course_3_count == 1) {
		// 	Turbolinks.pagesCached(10);
		// 	alert("turbolink cache now: " + Turbolinks.pagesCached());
		// }
	} 
	else {
		var diff = +new Date() - startTime;
		$("#score-time").val(diff);
	}
	$("#pointer").val($.trim($(".pointer-btns .active").text()));
	$("#hand").val($.trim($(".hand-btns .active").text()));
}

// Put game back to start state, except for right/left in parent method
function resetGame() {
	$("#start-btn").show();
	$("#selections").show();
	$("#done-btn").hide();
	leftClicks = 0;
	rightClicks = 0;
	count = 1;
}

