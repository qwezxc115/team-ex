<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>트리플 관리자페이지</title>
</head>
<style>

   #adminaddbtn {
      margin: 10px;
      padding: 5px;
   }
   
   td{
      text-align:center;
      valign : middle;
   }
   
   .btn-outline-secondary{
      background-color: #ececee;
   }
   
   #imgdiv {
      text-align:center;
   }
</style>
   
<script type="text/javascript">
   $(document).ready(function(){

      //로그아웃 동작 
       $("#navbar-logout-link").click(function(e) {
           e.preventDefault();
           $("#navbar-logout-form").submit();
         });

   });
</script>
<body>
   <sec:authorize access="hasRole('ROLE_ADMIN')">
   <div class = "container">
   
      <!-- 상단 메뉴바 -->
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${appRoot}/main/home">
         <img alt="triple-logo" width="100" src="${appRoot }/resources/img/triple-logo.png">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
          <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <li class="nav-item ">
              <a class="nav-link" href="${appRoot }/admin/home">회원 목록 </a>
            </li>
            <li class="nav-item ">
              <a class="nav-link" href="${appRoot }/admin/adminlist">관리자 목록</a>
            </li>
          </ul>
          <ul  class="navbar-nav">
            <li class="nav-item p-2">
               <span style="color:#6d0d27;"><b>현재 관리자로 로그인 중입니다</b></span>
               </li>
            <li class="nav-item">
                   <a class="nav-link" href="#" id="navbar-logout-link">로그아웃</a>
              </li>
         </ul>
         <form action="${appRoot }/logout" method="post" id="navbar-logout-form"> </form>
        </div>
      </nav>
      <hr style="border: solid 1px;">
  
  
   </div>
   </sec:authorize>
   <script>
   $(document).ready(function(){
      $("#returnbtn").click(function(){
         location.href="${appRoot }/main/home"; 
      })   
   })
   </script>
   <sec:authorize access="!hasRole('ROLE_ADMIN')">
   <div class = "container">
      <nb:navbar></nb:navbar>
      <h1 style="text-align:center"> 이곳은 트리플 관리자페이지 입니다.</h1>
      <h3 style="text-align:center"> 접근 권한이 없습니다.</h3>
         <div style="text-align:center">
            <button id=returnbtn type="button" style="width:400px; height:100px; margin:0 auto;"><span style="font-size:30px">트리플 돌아가기</span></button>
         </div>
   </div>
   </sec:authorize>
</body>
</html>