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

<title>업체 </title>
<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    .card{
    	max-width: 30%;
    }
    #imgsize{
    	max-width:100%;
    	height: 300px;
    }
    .imgview{
    	width: 100%;
    	height: 300px;
    }
    
    #textsize{
    	max-width: 100%;
    	height: 300px;
    }
</style>
<script type="text/javascript">

	$(document).ready(function(){
		

		//상담신청시 모달 나오게  
		var rezModal = $("#rez-modal")
		$("#rez-modal-btn").click(function(){
			rezModal.modal('show');
			
		})
		
		$(".page-link").click(function(e) {
			e.preventDefault();
			
			var page = $(this).attr("href");
			$("#actionForm [name=pageNum]").val(page);
			$("#actionForm").submit();
		});
			
	})
	
</script>
</head>
<body>

	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4"> 업체   </h3>
			
		</div>
		
		<div class="d-flex justify-content-start">
			<sec:authorize access="hasRole('ROLE_BUSINESS')"> 	
	      		  <a class="nav-link btn btn-outline-secondary" href="${appRoot}/experts/ewriting">글쓰기<i class="fas fa-pen"></i> </a>
      		</sec:authorize> 
	   </div>
	   <br>
		
		<div class="container m-1 row  row-cols-3">
			<c:forEach items="${elist}" var ="eboard">
				
				<div class="card col m-2 p-2">
					<input hidden name="eno" value="${eboard.eno }" />
					<div id="imgsize" class="text-center">
					 	<img class="imgview" src="${imgRoot}experts/${eboard.eno }/${eboard.fileName}" class="card-img-top" >
					</div>
					
					<div id="textsize" class="card-body" >
				    	<h5 class="card-title">${eboard.writerName }</h5>
				    	
				    	
				    	<c:url value="/experts/ereading" var="getebUrl">
								<c:param name="eno" value="${eboard.eno }" />
								<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
								<c:param name="amount" value="${pageMaker.cri.amount }" />
							</c:url>
				    	
				    		<a href="${getebUrl}">
								<span>${eboard.title }</span>
								
							</a> 
				    	
				   		 <p class="card-text">${eboard.content }</p>
					 </div>
					 
					 <ul class="list-group list-group-flush">
					 	<li class="list-group-item">${eboard.addRegion }</li>
					    <li class="list-group-item">${eboard.addCi }</li>
					    <li class="list-group-item">${eboard.addGu }</li>
					  </ul>
					  
					  <div class="card-body">
					    <span>작성일: <fmt:formatDate pattern="yyyy-MM-dd" value="${eboard.regdate }"/></span>
					  </div>
					</div>
				</c:forEach>
			</div>
		
		

		
			
	<!--  pagenation -->
	<br>
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
				<form id="actionForm" action="${appRoot }/experts/ehome" method="get">
					<input name="pageNum" value="${cri.pageNum }" />
					<input name="amount" value="${cri.amount }" />
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
						
						console.log("너 전에 왔었어!!!!");
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

		<c:if test="${not empty rezmsg}">
			<script type="text/javascript">
				alert("${rezmsg}");
			</script>
		</c:if>	
</body>
</html>