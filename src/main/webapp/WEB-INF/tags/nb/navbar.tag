<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script>

$(function() {
	//로그아웃 동작 
    $("#navbar-logout-link").click(function(e) {
        e.preventDefault();
        $("#navbar-logout-form").submit();
    });
	
})
</script>




<!--  검색  -->
<!-- 회원가입 페이지 ! -->
<!-- 기업 회원가입 페이지 ! -->
<!-- 회원정보 페이지 ! -->




<div class="d-flex justify-content-end">
	<nav class="navbar navbar-expand-sm navbar-light">
	
		<ul  class="navbar-nav">
	  		   <sec:authorize access="!isAuthenticated()">
					<li class="nav-item">
		       			 <a class="nav-link" href="${appRoot }/main/login">로그인 </a>
		     		 </li>
	     		</sec:authorize>
	     	
		     	<sec:authorize access="!isAuthenticated()">
				      <li class="nav-item">
				        <a class="nav-link" href="${appRoot }/main/tos" tabindex="-1" aria-disabled="true">회원가입 </a>
				      </li>
			     </sec:authorize>
			     <sec:authorize access="!isAuthenticated()">
			     
			     </sec:authorize>
		     	
		     	
		     		
  		 		<!-- 로그아웃, 마이페이지 로그인한 사용자만 보이게  -->
			     <sec:authorize access="isAuthenticated()">
			    
			      <li class="nav-item p-2">
			      	<sec:authentication property="principal.user.userName" />
			      	<span style="color:#6d0d27;">님 반갑습니다 !</span>
			      </li>
			      <li class="nav-item">
		            <a class="nav-link" href="#" id="navbar-logout-link">로그아웃</a>
		         </li>
		         </sec:authorize>
	         
		         <sec:authorize access="isAuthenticated()">

		         <li class="nav-item">
		       			 <a class="nav-link" href="${appRoot }/mypage/home">마이페이지 </a>
		     		 </li>
		     	</sec:authorize> 
		     	
		     	
		     	<sec:authorize access="isAuthenticated()">
		         <li class="nav-item">
<%-- 		         	<sec:authentication property="principal.user" var="user" />
 --%>		         	
		       		<a class="nav-link" href="${appRoot }/message/mgreceive">쪽지함 </a>
		     	 </li>
		     	 </sec:authorize>
		     	 
				<sec:authorize access="isAuthenticated()">
		         <li class="nav-item dropdown">
			      <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"></a>
			      <div class="dropdown-menu">
			        <a class="dropdown-item" href="${appRoot }/store/cart"><i class="fas fa-shopping-cart"></i> 장바구니</a>
			        <a class="dropdown-item" href="${appRoot }/store/wish"><i class="fas fa-heart"></i> 위시리스트</a>
			      </div>
			    </li>
		     	 </sec:authorize>
		     	 
		     	 
		     	 <sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item">
						<a class="nav-link" href="${appRoot }/admin/home" tabindex="-1" aria-disabled="true"  >관리자페이지 </a>
					</li>
		     	 </sec:authorize>
		     	 
			</ul>
		</nav>
</div>
<!-- 로그아웃  -->
		<form action="${appRoot }/logout" method="post" id="navbar-logout-form"> </form>
		

<div class="navbar row justify-content-center p-0">
		<div class="col-md-3 text-center p-0">
		  <a class="navbar-brand" href="${appRoot}/main/home"> 
		  	<img alt="gohome-logo" width="150" src="${appRoot }/resources/img/gohomelogo22.png">
		  </a>
		</div>
		
		<div class="form-group col-md-6 text-center m-1">
			<form class="form-inline text-center">
			<div class="input-group">
		  	  <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		  	  <div class="input-group-append">
		  	  	<button class="btn btn-outline-secondary"type="button"id="toggle-password-btn">
							      <i class="fas fa-search"></i>
				</button> 
		  	  </div>
			</div>
		 	 </form>
		</div>
</div>
  
<div class="navbar row justify-content-center p-0">
	<nav class="navbar navbar-expand-sm navbar-light">
    <ul class="navbar-nav mr-auto text-center">
    
      <li class="nav-item dropdown">
      	<a class="nav-link" href="${appRoot }/store/home"  role="button"  aria-expanded="false">
          스토어 
        </a>       
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
          커뮤니티 
        </a>
        <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">

          <li><a class="dropdown-item" href="${appRoot}/community/cbhome">자유게시판  </a></li>
          <li><a class="dropdown-item" href="${appRoot }/market/home">중고마켓  </a></li>
          <li><hr class="dropdown-divider"></li>
        </ul>
      </li>
      <!-- 업체 서브 빠이빠이  -->

      <li class="nav-item dropdown">
      	<a class="nav-link" href="${appRoot }/experts/ehome"  role="button"  aria-expanded="false">
          업체 
        </a>
        
      </li>

       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"  role="button"  aria-expanded="false">
         고객센터  
        </a>
       <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">

          <li><a class="dropdown-item" href="${appRoot }/cs/notice">공지사항 </a></li>
          <li><a class="dropdown-item" href="${appRoot }/cs/questionAndAnswer">Q&A</a></li>
          <li><a class="dropdown-item" href="${appRoot }/cs/oneToOne">1:1문의</a></li>
          <li><hr class="dropdown-divider"></li>

        </ul> 

      </li>
      
    </ul>
    </nav>
  </div>
  <hr class="m-1">