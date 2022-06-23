<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>자유게시판 글 목록  </title>

<style type="text/css">
	
	.top_bg{ 
		width: 100%;
	    height: 100px;
	   	
    }
    
   
</style>

<script type="text/javascript">

	$(document).ready(function() {
		$(".category-link").click(function(e) {
			e.preventDefault();
			var category = $(this).attr("data-category");
			$("#actionForm [name=cbcategory]").val(category);
			$("#actionForm").submit();
		});
		
		$(".form-select1").change(function(e) {
			e.preventDefault();
			var category = $(this).val();
			$("#actionForm [name=cbcategory]").val(category);
			$("#actionForm").submit();
		});
		
		$(".page-link").click(function(e) {
			e.preventDefault();
			
			var pageNum = $(this).attr("href");
			$("#actionForm [name=pageNum]").val(pageNum);
			$("#actionForm").submit();
	
		})
	})

</script>
</head>
<body>

	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">자유게시판 </h3>
			
		</div>
		
		<div class="d-flex justify-content-between p-3"  >
			<div class="d-flex ">
				<sec:authorize access="isAuthenticated()"> 	
		      		  <a class="nav-link btn btn-outline-secondary" href="${appRoot}/community/cbwriting">글쓰기<i class="fas fa-pen"></i> </a>
	      		</sec:authorize> 
			</div>
			
			<div class="d-flex ">
				  <!-- 검색  -->
				  <form action="${listUrl }" method="get" class="form-inline">
				  
				    	<select name="type" class="form-control mr-sm-2">
				    		<option value="">--</option>
				    		<!-- 3항연산식  -->
				    		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목 </option>
				    		<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용 </option>
				    		<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자 </option>
				    		<option value="TC" ${cri.type == "TC" ? 'selected' : '' }> 제목 or 내용 </option>
				    		<option value="TW" ${cri.type == "TW" ? 'selected' : '' }>제목 or 작성자 </option>
				    		<option value="TWC" ${cri.type == "TWC" ? 'selected' : '' }>제목 or 내용 or 작성자 </option>
				    	</select>
				    	<input name="keyword" value="${cri.keyword }" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
				    	
				    	
				  		<input type="hidden" name="pageNum" value="1">
				  	  	<input type="hidden" name="amount" value="${cri.amount }">
				    	<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
				  </form>
			</div>
		</div>
		
		<div class="container">
			<select class="form-select1" aria-label="Default select example">
					  <option >카테고리 </option>
					  <option ${cri.cbcategory == 'f' ? 'selected' : '' } value="f">자유 </option>
					  <option ${cri.cbcategory == 't' ? 'selected' : '' } value="t">팁 </option>
					  <option ${cri.cbcategory == 'r' ? 'selected' : '' } value="r">후기 </option>
			</select>
		</div>
		<br>
			
			
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#</th>
					<th>제목 </th>
					<th>작성자 </th>
					<th>작성일 </th>
					<th>수정일  </th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var ="cboard">
					<tr>
						<td>${cboard.bno }</td>
						<td>
							<c:url value="/community/cbreading" var="getUrl">
								<c:param name="bno" value="${cboard.bno }" />
								<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
								<c:param name="amount" value="${pageMaker.cri.amount }" />
								<c:param name="type" value="${pageMaker.cri.type }"></c:param>
								<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
							</c:url>

							<a href="${getUrl}">
								${cboard.title }
							</a> 
						</td>
						<td>${cboard.writerName }</td>
						<td>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${cboard.regdate }"/>
						</td>
						<td>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${cboard.updateDate }"/>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
			

	
	
	
	
	
	
	<!--  pagenation -->
		<div>
			<nav aria-label="Page navigation example">
			  <ul id="list-pagenation1" class="pagination justify-content-center">
			  
			  	<c:if test="${pageMaker.prev }">
				    <li class="page-item">
				      <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
				    </li>
			  	</c:if>
				
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
				
				    <li class="page-item" ${ num == cri.pageNum ? 'active' : '' }><a class="page-link" 
				    href="${num }">${num }</a></li>
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
				<form id="actionForm" action="${appRoot }/community/cbhome" method="get">
					<input name="pageNum" value="${cri.pageNum }" />
					<input name="amount" value="${cri.amount }" />
					<input name="type" value="${cri.type }" />
					<input name="keyword" value="${cri.keyword }" />
					<input name="cbcategory" value="${cri.cbcategory }" />
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
						
						console.log("너 전에 여기 왔었어!!!!");
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