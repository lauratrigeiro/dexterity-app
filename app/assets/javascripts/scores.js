var leftClicks = 0;
var rightClicks = 0;
var startTime;

$(".scores.new").ready(function() {
	$(".pointer-btns .btn").click(function() {
		
		if(!$(this).hasClass("active")) {
			$(".pointer-btns .active").removeClass("active");
			$(this).addClass("active");
		}
	});

	$(".hand-btns .btn").click(function() {
		
		if(!$(this).hasClass("active")) {
			$(".hand-btns .active").removeClass("active");
			$(this).addClass("active");
		}
	});

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
				$("#score-time").val(diff);
				$("#pointer").val($.trim($(".pointer-btns .active").text()));
				$("#hand").val($.trim($(".hand-btns .active").text()));
				$("#done-form").submit();
			});
		}
		else {
			$("#right-btn").attr('disabled', true);
			$("#left-btn").attr('disabled', false);
		}
	});

});
