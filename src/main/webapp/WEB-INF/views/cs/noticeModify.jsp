<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>공지사항 수정</title>

<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    
    #img-preview{
   		max-width: 90%;
    }
</style>

<script type="text/javascript">

	$(document).ready(function() {
		var modifyUrl = "${appRoot }/cs/noticebModify";
		var deleteUrl = "${appRoot }/cs/noticeDelete";
		$("#cs_noticeDelete_btn").click(function() {
			if (confirm("삭제 하시겠습니까?")) {
				$("#modify-form").attr("action", deleteUrl);
				$("#modify-form").submit();
			}
		});

		
		//제목입력확인 
		$("#writingbtn").click(function() {
			if($("#input-title").val()==""){
				alert("제목을 입력해주세요 .");
				$("#input-title").focus();
				return false;
			}
			
		});
		
		$("#input3").change(function() {
			const file = this.files[0];
			
			if (file) {
				$("#img-preview").attr("src", URL.createObjectURL(file));
			}
			
			$(this).next().text(file.name)
		})
		
});
</script>
</head>
<body>

	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">공지사항 글 수정하기  </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
				<form id="modify-form" action="${appRoot }/cs/noticeModify"  method="post" enctype="multipart/form-data" >
					<input hidden name="nno" value="${nvo.nno }" />
					
					<div class="form-group">
						<label for="input1">제목</label>
						<!-- 공지사항 수정 시 (수정)표시 할 수 있도록 readonly 삭제함	 -->
						<input id="input1" class="form-control" name="ntitle" value="${nvo.ntitle }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="textarea1" class="form-control" name="ndetail" rows="30"><c:out value="${nvo.ndetail }" /></textarea>
					</div>
					
					<c:if test="${not empty nvo.fileName }">
					
						<div class="form-group">
							<p>첨부파일
							<c:forEach items="${nvo.fileName }" var="notice_file"> 
							<img class="img-fluid" 
							src="${imgRoot}notice/${nvo.nno }/${notice_file}">
							</c:forEach>
							<p>파일 수정 
						</div>
					</c:if>
					
					<div class="custom-file">
						<input id="input3" class="custom-file-input" type="file" name="notice_file" multiple="multiple" accept="image/*" aria-describedby="선택 ">
						<label class="custom-file-label" for="input3">파일</label>
					</div>
					
					<div class="form-group mt-3">
						<img id="img-preview" src="" alt="미리보기	">
					</div>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input readonly="readonly" id="input2" class="form-control" name="userid" value="${nvo.userid }">
					</div>	
						
					<input hidden name="pageNum" value="${cri.pageNum }" />
					<input hidden name="amount" value="${cri.amount }" />	
						
					<div class="input-group justify-content-between">
						<input class="btn btn-warning" type="submit" value="수정" />
						<input id="cs_noticeDelete_btn" class="btn btn-danger" type="button" value="삭제" />
					</div>
				</form>
			</div>
		</div>
		
		<footer>
			<nb:footer></nb:footer>
		</footer>
	</div>
	
		
	

	
</body>
</html>