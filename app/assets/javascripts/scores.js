var leftClicks = 0;
var rightClicks = 0;
var startTime;
//var endTime;

$(".scores.new").ready(function() {
	$("#start-btn").click(function(){
		startTime = +new Date();
		$(this).hide();
		$("#left-btn").attr('disabled', false);
	});
	
	$("#left-btn").click(function(){
		leftClicks++;
		$("#right-btn").attr('disabled', false);
		$("#left-btn").attr('disabled', true);
		console.log("left: " + leftClicks);
	});
	$("#right-btn").click(function(){
		rightClicks++;
		console.log("right: " + rightClicks);
		if(leftClicks == 5 && rightClicks == 5) {
			endTime = new Date($.now());
			$(".game-btn").hide();
			$("#done-btn").show();
			$("#done-btn").click(function(){
				var diff = (+new Date() - startTime)/1000.0;
				alert(diff/1000.0);
			});
		}
		else {
			$("#right-btn").attr('disabled', true);
			$("#left-btn").attr('disabled', false);
		}
	});

});
