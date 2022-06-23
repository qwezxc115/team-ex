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
<title>게시글 보기 </title>
</head>
<body>

	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">자유게시판 글보기 </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
				<form >
				
					<div class="form-group">
						<label for="input1">제목</label>
						<input readonly="readonly" id="input1" class="form-control" name="title" value="${cboard.title }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" 
						name="content" rows="10"><c:out value="${cboard.content }" /></textarea>
					</div>
					
					
					<c:if test="${not empty cboard.fileName }">
					
						<div class="form-group">
							<img class="img-fluid" 
							src="${imgRoot}cboard/${cboard.bno }/${cboard.fileName}">
						</div>
						
					</c:if>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input readonly="readonly" id="input2" class="form-control" name="writer" value="${cboard.writerName  }">
					</div>		
					
					<c:url value="/community/cbmodify" var="modifyUrl">
						<c:param name="bno" value="${cboard.bno }" />
						<c:param name="pageNum" value="${cri.pageNum }" />
						<c:param name="amount" value="${cri.amount }" />
						<c:param name="type" value="${cri.type }" />
						<c:param name="keyword" value="${cri.keyword }" />
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