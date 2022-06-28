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
      
		#btn-outline-secondary{
			background-color: #ececee;
		}
		#btn-outline-secondary:hover{
			background-color: #6d0d27;
		}
		#signupbtn{
			background-color: #6d0d27;
			color:#fff;
		}
		#bkbtn{
			background-color:#daccc6;
		}
      
       #findidbtn{
      	width: 100%;
      	background-color:#daccc6;
      	font-weight:550;
      	border: none;
      }
      
        #findidbtn:hover {
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
			$("#findidbtn").on("click", function(){
				if($("#nameinput").val()==""){
					alert("이름을 입력해주세요.");
					$("#nameinput").focus();
					return false;
				}
				if($("#phoneinput").val()==""){
					alert("휴대폰 번호를 입력해주세요.");
					$("#phoneinput").focus();
					return false;
				}
			});
			
				
			
		})
</script>


<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>아이디 찾기</title>
</head>
<body style="background-color: #ececee;">
<div class="container">
	<div class="jumbotron" style="background-color:#fff;">
		<div class="text-center p-3">
            <a href="${appRoot }/main/home">
             <img alt="gohome" width="250" src="${appRoot }/resources/img/triple-logo.png"></a>
        </div>
	
			 <!-- 아이디 찾기 -->
             <div class="row justify-content-center ">
				<form class="form-signin col-5"  action="${appRoot }/main/findId" name="findform" method="post" >
				
					<!-- 이름과 전화번호 입력 -->
					<div class="form-label-group">
						<label for="userName" ></label>				
						<input type="text" id="nameinput" class="form-control" name="userName" placeholder="Name"  />
					</div>
					<div class="form-label-group">
						<label for="userPhone"></label>
						<input type="text" id="phoneinput" class="form-control" name="userPhone" placeholder="Phone" />
					</div>

					<!-- 입력 값 전송 -->
					<div class="form-label-group mt-5">
						<input 	type="submit" id="findidbtn" class="btn" value="아이디 찾기">							
					</div>

					<!-- 입력 값에 따른 결과 값 안내 -->
					<!-- 1. 이름과 전화번호가 일치하지 않는 경우 -->
					<c:if test="${check == 1}">
						<script>
							opener.document.findform.name.value = "";
							opener.document.findform.phone.value = "";
						</script>
						
						<script>
							alert("일치하는 정보가 존재하지 않습니다.")
						</script>
					</c:if>
			
					<!-- 2. 이름과 전화번호가 일치하는 경우 -->
					<c:if test="${check == 0 }">
						<script>
						alert("찾으시는 아이디는"+' ${id}' +"입니다.")
						</script>
					
					</c:if>
			
				</form>
			</div>
				
				
<hr>
			<!-- 부가 버튼 : 비밀번호 찾기, 로그인, 회원가입 -->
			<div class="row justify-content-center text-center m-2">
				<div class="col-2">
					<a href="${appRoot }/main/findPw" >
						비밀번호 찾기
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
