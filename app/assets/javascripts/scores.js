var leftClicks = 0;
var rightClicks = 0;
var startTime;
var count = 1;
var nextId;
var course_3_count = 0;

$(".scores.new").ready(function() {
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
		startTime = +new Date();
		$(this).hide();
		$("#selections").hide();
		$("#scroll-down").hide();
		$(".game-btn").show();
		if($("#course").val() == 3) {
			$("#done-btn").show();
		}
	});
	
	if($("#course").val() == 1) {
		$("#left-btn").click(function(){
			leftClicks++;
			$("#right-btn").attr('disabled', false);
			$("#left-btn").attr('disabled', true);
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
			$("#right-btn").attr('disabled', true);
			$("#left-btn").attr('disabled', false);
		});
	}

	else if($("#course").val() == 2) {
		$("#course-btns").on('click', '.next-btn', (function() {
			$(this).attr('disabled', true);
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
	//		console.log("next id: " + "#btn-"+nextId);
			$('#btn-'+nextId).addClass('next-btn');
			$('#btn-'+nextId).attr('disabled', false);
		}));
	}

	else if($("#course").val() == 3) {
			console.log("course 3");
	//	$("#course-btns").on('click', '#course-3-btn', (function() {
		//	$(this).attr('disabled', true);
	//		alert("hey there! " + course_3_count);
		//	course_3_count += 1;
	//		$(".game-btn").hide();
			$("#done-btn").click(function(){
					course_3_count += 1;
				 	onDone();
		//			resetGame();
				});
		//	onDone();
		//	$("#done-form").submit();
			//$('#done-form').closest('form').trigger('submit');
	//	}));
	}
	else {
		alert("Not a valid course!");
	}
});

function onDone() {
	// Game is done, calculate time and remember game settings
	if($("#course").val() == 3) {
		$("#score-time").val(course_3_count);
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

