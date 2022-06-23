<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<!--  
<link href="${pageContext.request.contextPath }/res/css/all.css" rel="stylesheet">
 --> 
 
 
 <script defer src="${pageContext.request.contextPath }/resources/js/all.js"></script>
 
<!-- 
security info
 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo" scope="request" />
</sec:authorize>



<!-- 글꼴 수정 -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

 body{
 font-family: 'Do Hyeon', sans-serif;
 }
</style>