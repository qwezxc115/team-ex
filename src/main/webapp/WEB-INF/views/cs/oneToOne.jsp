<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<script>
$(document).ready(function() {
	$("#list-pagenation2 a").click(function(e) {
		// 기본 액션 중지 (hyperlink 역할 안함)
		e.preventDefault();
		
		//console.log("a요소 클릭됨");
		
		var actionForm = $("#actionForm");
		
		// form의 pageNum input의 값을 a 요소의 href값으로 변경
		actionForm.find("[name=pageNum]").val($(this).attr("href"));
		
		// submit
		actionForm.submit();
	});
});
</script>

<title>1:1문의</title>
</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">1:1문의</h3>
			
		</div>
		
		<a href="${appRoot }/cs/otowriting"><i class="fas fa-pen"></i> 글쓰기</a>
		
		
		<table class="table table-striped">
		<thead>
			<tr>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${list }" var="board" varStatus="boardStatus">
				<tr>
					<td>${boardStatus.count }</td>
					<td><a href="${appRoot }/cs/otoreading?qono=${board.qono}">${board.otitle }</a></td>
					<td>${board.userid }</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.oregdate }"/></td>
				</tr>
			</c:forEach>			
		</tbody>
		</table>



	<!--  pagenation -->
		<div>
			<nav aria-label="Page navigation example">
			  <ul id="list-pagenation2" class="pagination justify-content-center">
			  
			  	<c:if test="${pageMaker.prev }">
				    <li class="page-item">
				      <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
				    </li>
			  	</c:if>
				
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
				
				    <li class="page-item ${num == cri.pageNum ? 'active' : '' }"><a class="page-link" href="${num }">${num }</a></li>
				</c:forEach>
			
				<c:if test="${pageMaker.next }">
				    <li class="page-item">
				      <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
				    </li>
				</c:if>
			  </ul>
			</nav>
			
			<!--페이지 링크용 form  -->
			<div style="display: none;">
				<form id="actionForm" action="${appRoot }/cs/oneToOne" method="get">
					<input name="pageNum" value="${pageMaker.cri.pageNum }" />
					<input name="amount" value="${pageMaker.cri.amount }" />
				</form>
			</div>
		</div>
	
	<!-- 게시글등록성공시 모달 나오게   -->
		<c:if test="${not empty result }" >
			<script>
			$(document).ready(function() {
				
				if (history.state == null) {
					$("#board-modal1").modal('show');
					history.replaceState({}, null);
				}
				 else {
						
						console.log("게시글 등록 성공");
					}
			});
			</script>
			
			<div id="board-modal1" class="modal" tabindex="-1">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">${messageTitle } </h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <p>${messageBody } </p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
		</c:if>
		
		
			

		<footer>
			<nb:footer></nb:footer>
		</footer>
		
	</div>

</body>
</html>