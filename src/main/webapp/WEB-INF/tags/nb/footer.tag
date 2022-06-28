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
	         <a class="nav-link p-0" href="${appRoot }/cs/oneToOne"  role="button" >고객센터</a>
	         <p>상호명 : (주)어디로든문 | 대표 : 트리플 | 사업자번호:000-12-34567</p>
	         <p>주소 : 서울특별시 강남구 테헤란로777 | 이메일 : info@triple.co.kr | 전화번호 : 010-1234-5678</p>
         </div>
		
		
		<div class="align-items-center text-center">
			<a class="navbar-brand" href="${appRoot}/main/home"> 
		  		<img alt="triple-logo" width="200" src="${appRoot }/resources/img/triple-logo.png">
		 	 </a>
		 	 <p><small>Copyright &copy;2022 By 트리플, All rights reserved </small></p>
		</div>
	</div>
</div>
