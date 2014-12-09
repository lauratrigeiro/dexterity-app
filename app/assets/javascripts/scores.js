var leftClicks = 0;
var rightClicks = 0;
var startTime;

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
		$(".game-btn").show();
	});
	
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
				// Game is done, calculate time and remember game settings
				var diff = +new Date() - startTime;
				$("#score-time").val(diff);
				$("#pointer").val($.trim($(".pointer-btns .active").text()));
				$("#hand").val($.trim($(".hand-btns .active").text()));
				resetGame();
			});
		}
		$("#right-btn").attr('disabled', true);
		$("#left-btn").attr('disabled', false);
	});

});

// Put game back to start state, except for right/left in parent method
function resetGame() {
		$("#start-btn").show();
		$("#selections").show();
		$("#done-btn").hide();
		leftClicks = 0;
		rightClicks = 0;
	}

