<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
	#footer{
		
	}
	.telnum{font-size:20px;}
	
	#info p{
		margin: 0; padding: 5px; 
	}
</style>

<div id="footer"class="container">
	<hr>
	<div class="d-flex justify-content-between p-2">
		<div class="text-left">
	         <a class="nav-link p-0" href="${appRoot }/help/cs"  role="button" >고객센터 </a>
	         <span class="telnum"><strong>1234-5678</strong></span>
	         <p>월~금 9:00~18:00 <br>(점심시간12:00~13:00)</p>
	         <p >상호명:(주)어디로든문 | 사업자등록번호:000-123-45678 | 주소 : 서울특별시 강남구 테헤란로777 </p>
         </div>
		
		
		<div class="align-items-center text-center">
			<a class="navbar-brand" href="${appRoot}/main/home"> 
		  		<img alt="triple-logo" width="200" src="${appRoot }/resources/img/triple-logo.png">
		 	 </a>
		 	 <p><small>Copyright &copy;2022 By 트리플, All rights reserved </small></p>
		</div>
	</div>
</div>
