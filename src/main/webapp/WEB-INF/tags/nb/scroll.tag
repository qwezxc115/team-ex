<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
/* PC TOP 버튼 */
#scrollUp {
  display: none;
  position: fixed;
  bottom: 64px; /* 윗쪽 끝에서부터의 거리 */
  right: 15px; /* 오른쪽 끝에서부터의 거리 */
  cursor: pointer;
  z-index: 99;
}

/* PC DOWN 버튼 */
#scrollDown {
  display: none;
  position: fixed;
  bottom: 20px; /* 윗쪽 끝에서부터의 거리 */
  right: 15px; /* 오른쪽 끝에서부터의 거리 */
  cursor: pointer;
  z-index: 99;
}
</style>


<script>
	$(function() {
 		$(window).scroll(function() {
			if ($(this).scrollTop() > 200) {
				$('#scrollUp').fadeIn();
				$('#scrollDown').fadeIn();
			} else {
				$('#scrollUp').fadeOut();
				$('#scrollDown').fadeOut();
			}
		}); 
	        
		$("#scrollUp").click(function() {
			$('html, body').animate({scrollTop : 0}, 400);
			});
		$("#scrollDown").click(function(){
			$('html, body').animate({scrollTop:($('body').height())}, 200);
			});	
		return false;
		});
</script> 


<!-- PC TOP 버튼 HTML -->
<div id="scrollUp">Up
   <!--  <img src="버튼이미지주소" width="가로길이px" height="세로길이px> -->
</div>

<div id="scrollDown">Down
   <!--  <img src="버튼이미지주소" width="가로길이px" height="세로길이px> -->
</div>
