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
<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    
    .row{
    	padding-bottom: 20px;
    }
    
</style>
<title>1:1문의 글 보기</title>
</head>
<body>

	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">1:1문의 글 보기 </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
				<form action="${appRoot }/cs/otodelete" method="post">
					<div class="form-group" style="display:none;">
						<label for="qono">게시글 번호</label>
						<input readonly="readonly" id="qono" class="form-control" name="qono" value="${ovo.qono }">
					</div>
					
					<div class="form-group">
						<label for="input1">제목</label>
						<input readonly="readonly" id="input1" class="form-control" name="otitle" value="${ovo.otitle }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" 
						name="odetail" rows="10"><c:out value="${ovo.odetail }" /></textarea>
					</div>
					
					<!-- 은비 수정 8-16 -->
					<div class="form-group">
							<c:if test="${not empty ovo.fileName }">
								<c:forEach items="${ovo.fileName }" var="oto_file">
									<div class="col-3">
										<img class="img-fluid"
											src="${imgRoot}oto/${ovo.qono }/${oto_file}">
									</div>
								</c:forEach>
							</c:if>
					</div>
				
					<div class="form-group">
						<label for="input2">작성자</label>
						<input readonly="readonly" id="input2" class="form-control" name="userid" value="${ovo.userid }">
					</div>		
					
					<hr>
					
					<div class="form-group">
						<label for="textarea1">관리자 답변</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" rows="10"><c:out value="${ans.content }" /></textarea>
					</div>
					
					<hr>
					
					<c:url value="/community/cbmodify" var="modifyUrl">
						<c:param name="bno" value="${cboard.bno }" />
						<c:param name="pageNum" value="${cri.pageNum }" />
						<c:param name="amount" value="${cri.amount }" />
					</c:url>
						
					<c:if test="${pinfo.user.userid eq cboard.writer }" >
						<a class="btn btn-secondary" href="${modifyUrl }">수정/삭제</a>
					</c:if>
	
					
				
				</form>
			</div>
		</div>
		
		
		
		<footer>
			<nb:footer></nb:footer>
		</footer>
	</div>
	
		
	

</body>
</html>