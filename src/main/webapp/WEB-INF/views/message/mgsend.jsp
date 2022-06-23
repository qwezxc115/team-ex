<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<style>
#td {
	vertical-align: middle;
}
</style>
<title>쪽지함</title>
<script>
$(function() {
	$("#callsec").on("show.bs.modal", function() {
		$("#readerTh").val("");
		$("#contentTh").val("");
		$("#sendbtnTh").prop("disabled", true);
		
		$("#contentTh").keyup(function(){
			$("#sendbtnTh").prop("disabled", false);	
		})
	})
});
</script>

</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>
		<div class="d-flex justify-content-center p-0">
			<nav class="navbar navbar-expand-sm navbar-light">
				<ul class="navbar-nav mr-auto text-center">
					<li class="nav-item"><font size="4px"> <a
							class="nav-link" href="${appRoot }/message/mgreceive">받은쪽지함 </a>
					</font></li>
					<li class="nav-item"><font size="4px"> <a
							class="nav-link" href="${appRoot }/message/mgsend">보낸쪽지함 </a>
					</font></li>
					<li class="nav-item"><font size="4px"> <a
							class="nav-link" type="button" data-toggle="modal"
							data-target="#callsec"> 쪽지 보내기 </a>
					</font></li>
				</ul>

			</nav>
		</div>
		<form method="GET" action="${appRoot }/message/search">
			<label>제목 검색</label> <input type="text" name="searchValue"> <input
				type="hidden" name="type" value="send" /> <input type="submit"
				value="검색">
		</form>
		<h3>보낸 쪽지함</h3>
		<table class="table table-striped">
			<thead>
				<tr style="text-align: center">
					<th style="width: 8%">번호</th>
					<th style="width: 65%">내용</th>
					<th style="width: 15%">받은사람</th>
					<th style="width: 12%">작성일</th>
				</tr>
			</thead>
			<tbody>


				<c:forEach items="${listsend }" var="message" varStatus="status">
					<tr>
						<td id="td" style="text-align: center">
							<!-- ${message.mno} 확인용 mno --> ${status.count }
						</td>
						<td id="td"><a type="button" class="nav-link active"
							id="cnbtn1" data-toggle="modal"
							data-target="#call${status.count }"> ${message.content } </a></td>
						<td id="td" style="text-align: center">${message.reader }</td>
						<td id="td" style="text-align: center"><fmt:formatDate
								pattern="yyyy-MM-dd [hh:mm]" value="${message.regdate }" /></td>
					</tr>

					<!-- 모달 -->
					<div class="modal fade" id="call${status.count }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">보낸 쪽지함</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form method="post" action="${appRoot }/message/delete">
										<div class="form-group" style="display: none;">
											<label for="mno" class="col-form-label">번호</label> <input
												type="text" readonly class="form-control"
												id="mno${status.count }" value="${message.mno }" name="mno">
										</div>
										<div class="form-group">
											<label for="writer" class="col-form-label">보내는 사람</label> <input
												type="text" readonly class="form-control"
												id="writer${status.count }" value="${uservo.userid}"
												name="writer">
										</div>

										<div class="form-group">
											<label for="reader" class="col-form-label">받는 사람</label> <input
												type="text" readonly class="form-control"
												id="reader${status.count }" name="reader"
												value="${message.reader}">
										</div>

										<div class="form-group">
											<label for="content" class="col-form-label">내용</label>
											<textarea class="form-control" readonly
												id="content${status.count }" name="content">${message.content}</textarea>
										</div>

										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal" id="close1">Close</button>
											<button id="mesdelbtn${status.count }" type="submit"
												class="btn btn-danger mr-auto">삭제</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<div style="display: none;">
		<form id="actionForm" action="${appRoot }/message/list" method="get">
			<input name="pageNum" value="${pageMaker.cri.pageNum }" /> <input
				name="amount" value="${pageMaker.cri.amount }" />
		</form>
	</div>



	<div class="modal fade" id="callsec" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">쪽지 전송하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="${appRoot }/message/mgsend" method="post">
						<div class="form-group">
							<label for="writer" class="col-form-label">보내는 사람</label> <input
								type="text" readonly class="form-control" id="writerTh"
								value="${uservo.userid}" name="writer">
						</div>

						<div class="form-group">
							<label for="reader" class="col-form-label">받는 사람</label> <input
								type="text" class="form-control" id="readerTh" name="reader">
						</div>

						<div class="form-group">
							<label for="content" class="col-form-label">내용</label>
							<textarea class="form-control" id="contentTh" name="content"></textarea>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
							<button id="sendbtnTh" type="submit" class="btn btn-secondary">보내기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--  pagenation -->
	<div>
		<nav aria-label="Page navigation example">
			<ul id="list-pagenation1" class="pagination justify-content-center">
				<c:if test="${pageMaker.prev }">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.startPage - 1 }">Previous</a></li>
				</c:if>

				<c:forEach begin="1" end="${total / 10 }" var="num">
					<li class="page-item"><a class="page-link"
						href="?page=${num }">${num }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>
			</ul>
		</nav>

		<div style="display: none;">
			<form id="actionForm" action="${appRoot }/message/list" method="get">
				<input name="pageNum" value="${pageMaker.cri.pageNum }" /> <input
					name="amount" value="${pageMaker.cri.amount }" />
			</form>
		</div>


	</div>
	<c:if test="${not empty message}">
		<script>
	alert("${message}");
	$(document).ready(function() {
	var canUseId = false;
	
	$("#sendbtnTh").click(function(){
		var idVal = $("#readerTh").val();
		var messageElem = $("#id-message");
		canUseId = false;
		
		if(idVal == "") {
			messageElem.text("입력해주세요.");
		} else {
			var data = {id : idVal};
			$.ajax({
				type: "get",
				url: "${appRoot }/main/dup",
				data: data,
				success: function (data) {
					if (data == "success") {
						console.log("전송 가능한 아이디");
						canUseId = true;
					} else if (data == "exist") {
						console.log("전송 불가능한 아이디");
					}
					
				}
			})
		}
		})
	})
</script>
	</c:if>

		<footer>
			<nb:footer></nb:footer>
		</footer>	
	
</body>
</html>