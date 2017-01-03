	$(".class-item").hover(function(){
		if($(this).attr("wn-statue")=='0'){
			var tmp_width = $(this).width();
  			var tmp_height = $(this).height();
			$(this).attr("wn-width",tmp_width);
			$(this).attr("wn-height",tmp_height);
			$(this).attr("wn-statue",'1');
		}
		$(".class-item.action").removeClass("action");
		$(this).addClass("action");
  		var width = $(this).children('.p-container').width()+5;
  		var old_width = $(this).attr("wn-width");
  		var height = $(this).attr("wn-height");
  		var top = $(this).position().top;
  		var left = $(this).position().left;
  		if(width-old_width>10){
  			var now_width = width;
  		}else{
  			var now_width = old_width*1.2;
  		}
  		$(this).stop(false,true).animate({ height:String(height*1.2)+"px",
  										  width:String(now_width)+"px",
  										  top:String(top-height*0.1)+"px",
  										  left:String(left-now_width*0.1)+"px"},500);
  	},function(){
  		var width = $(this).attr("wn-width");
  		var height = $(this).attr("wn-height");
  		var top = $(this).position().top;
  		var left = $(this).position().left;
  		$(this).stop(false,true).animate({ height:String(height)+"px",
  										  width:String(width)+"px",
  										  top:"0px",
  										  left:"0px"},500)
  	});
