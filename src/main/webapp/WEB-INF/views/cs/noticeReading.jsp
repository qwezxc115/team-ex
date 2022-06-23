<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<title>공지사항 글보기</title>
</head>
<body>
<div class="container">
		<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">공지사항 </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
			<form>
					<div class="form-group" style="display:none;">
						<label for="nno">게시글 번호</label>
						<input readonly="readonly" id="nno" class="form-control" name="nno" value="${nvo.nno }">
					</div>
					
					<div class="form-group">
						<label for="input1">제목</label>
						<input readonly="readonly" id="input1" class="form-control" name="ntitle" value="${nvo.ntitle }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" name="ndetail" rows="10"><c:out value="${nvo.ndetail }" /></textarea>
					</div>

						<div class="form-group">
							<c:if test="${not empty nvo.fileName }">
								<c:forEach items="${nvo.fileName }" var="notice_file">
									<div class="col-3">
										<img class="rounded float-left"
											src="${imgRoot}notice/${nvo.nno }/${notice_file}">
									</div>
								</c:forEach>
							</c:if>
						</div>

						<c:url value="/cs/noticeModify" var="modifyUrl">
						<c:param name="nno" value="${nvo.nno }" />
						<c:param name="pageNum" value="${cri.pageNum }" />
						<c:param name="amount" value="${cri.amount }" />
					</c:url>
						
					<c:if test="${pinfo.user.userid eq nvo.userid }" >
						<a class="btn btn-secondary" href="${modifyUrl }">수정</a>
					</c:if>
				</form>
			</div>
		</div>
	</div>
	
		<footer>
			<nb:footer></nb:footer>
		</footer>
	
</div>
</body>
</html>