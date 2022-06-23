<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>로그인</title>

<style type="text/css">

	html, body {
	    height: 100%;
	    min-height: 100%;
	}
	.container{
       height: 100%;
	}
	.jumbotron{
        width: 100%;
        height: 100%;
      }
      
      #lgbtn{
      	width: 100%;
      	background: linear-gradient( to right, #B8E9FF, #18A8F1 );
      	font-weight:550;
      }
     hr{
     	height:2px;
     }
</style>

<script type="text/javascript">

		$(document).ready(function(){
			
			$("#lgbtn").on("click", function(){
				if($("#idinput").val()==""){
					alert("아이디를 입력해주세요.");
					$("#idinput").focus();
					return false;
				}
				if($("#pwinput").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#pwinput").focus();
					return false;
				}
				
			});
			
				
			
		})
</script>
</head>
<body style="background-color: #ececee;">

	<div class="container " >
        <div class="jumbotron" style="background-color:#fff;">
        
            <div class="text-center p-5">
                  <a href="${appRoot }/main/home">
                  <img alt="triple" width="250" src="${appRoot }/resources/img/triple-logo.png"></a>
            </div>
            
             <div class="row justify-content-center ">
				<form class="col-5"  action="${appRoot }/login" method="post" >
					<div class="form-group"> 
						<label for="idinput" ></label>				
						<input id="idinput" class="form-control" name="username" placeholder="아이디 " />
					</div>
					<div class="form-group">
						<label for="pwinput"></label>
						<input id="pwinput" type="password" class="form-control" name="password" placeholder="비밀번호" />
					</div>
					<div class="form-group mt-5">							
						<input id="lgbtn" class="btn" type="submit" value="로그인">
					</div>
					<div class="form-group form-check">
						<input name="remember-me" type="checkbox" class="form-check-input" id="checkbox1"/>
						<label class="form-check-label" for="checkbox1">로그인 상태유지</label>
					</div>
							
					</form>
				</div>
				<hr>
				
				<div class="row justify-content-center text-center m-2">
					<div class="col-2">
						<a href="${appRoot }/main/findId" target="_blank">
							아이디 찾기
						</a>
					</div>
					<div class="col-2">
						<a href="${appRoot }/main/findPw" target="_blank">
							비밀번호 찾기
						</a>
					</div>
					<div class="col-2">
						<a href="${appRoot }/main/tos">
							회원가입
						</a>
					</div>
				</div>
				
           </div>
      </div>
</body>
</html>