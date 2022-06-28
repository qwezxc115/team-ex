<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	html, body {
	    height: 100%;
	    min-height: 100%;
	}
	.container {
       height: 100%;
	}
	.jumbotron {
        width: 100%;
        height: 100%;
      }
      
       #findpwbtn{
      	width: 100%;
      	background-color:#daccc6;
      	font-weight:550;
      	border: none;
      }
      
        #findpwbtn:hover {
      	width: 100%;
      	background: linear-gradient(to right, #B8E9FF, #18A8F1 );
      	border: none;
      }
      
     
     hr{
     	height:2px;
     }
</style>

<%@ include file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<script type="text/javascript">
		$(document).ready(function(){
			$("#findpwbtn").on("click", function(){
				if($("#idinput").val()==""){
					alert("아이디를 입력해주세요.");
					$("#idinput").focus();
					return false;
				}
				if($("#emailinput").val()==""){
					alert("이메일을 입력해주세요.");
					$("#emailinput").focus();
					return false;
				}
			});
		});
</script>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>비밀번호 찾기</title>
</head>
<body style="background-color: #ececee;">
<div class="container">
	<div class="jumbotron" style="background-color:#fff;">
		<div class="text-center p-3">
            <a href="${appRoot }/main/home">
             <img alt="gohome" width="250" src="${appRoot }/resources/img/triple-logo.png"></a>
        </div>
        
		<!-- 비밀번호 찾기 -->
	    <div class="row justify-content-center ">
			<form class="form-signin col-5" action="${appRoot }/main/findPw" name="findform" method="post"  >
				
				<!-- 아이디 & 이메일 입력 -->
				<div class="form-label-group">
					<label for="userid"></label>
					<input type="text" id="idinput" name="userid" class="form-control" placeholder="ID" />
					
				</div>
				
				<div class="form-label-group">
					<label for="userEmail"></label>
					<input type="text" id="emailinput" name="userEmail" class="form-control" placeholder="Email"/>
					
				</div>
		
				<!-- 입력 값 전송 -->
				<div class="form-label-group mt-5">
					<input 	type="submit" id="findpwbtn" class="btn" value="비밀번호 찾기">							
				</div>
							
				<!-- 입력 값에 따른 결과 값 안내 -->
				<!-- 1. 등록된 아이디가 없는 경우 -->
				<c:if test="${check == 1}">
					<script>
						opener.document.findform.id.value = "";
						opener.document.findform.email.value = "";
					</script>
					<script>
						alert("등록되지 않은 아이디입니다.")
					</script>
				</c:if>
				
				<!-- 2. 등록된 이메일과 작성한 이메일이 일치하지 않는 경우 -->
				<c:if test="${check == 2}">
					<script>
						opener.document.findform.id.value = "";
						opener.document.findform.email.value = "";
					</script>
					<script>
						alert("일치하는 정보가 존재하지 않습니다.")
					</script>
				</c:if>
				
		
				<!-- 3. 아이디와 이메일이 등록정보와 일치할 때-->
				<c:if test="${check == 0 }">
					<script>
						alert("임시 비밀번호를 가입시 작성한 이메일로 발송했습니다.")
					</script>
				</c:if>
			</form>
		</div>
		
		
<hr>
			<!-- 부가 버튼 : 아이디 찾기, 로그인, 회원가입 -->
			<div class="row justify-content-center text-center m-2">
				<div class="col-2">
					<a href="${appRoot }/main/findId" >
						아이디 찾기
					</a> 
				</div>

				<div class="col-2">
					<a href="${appRoot }/main/login">
						로그인
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