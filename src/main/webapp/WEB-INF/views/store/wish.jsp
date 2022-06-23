<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>장바구니</title>
</head>
<body>
	<div class="container">
		<nb:navbar/>
		<nb:scroll/>		
		<br>
		<h2>위시리스트</h2>
		<br>
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th>#</th>
					<th>제품명</th>
					<th>상세설명</th>
					<th>가격</th>
					<th>찜 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="wishlist" items="${wishlist}" varStatus="status">
					<tr>
						<th>${ status.count }</th>
						<th>${wishlist.title }</th>
						<td>${wishlist.detail }</td>
						<td>${wishlist.price}</td>
						<td>
 							<form action="${appRoot }/store/wishdelete" method="post">
								<input name="wno" type="hidden" value="${wishlist.wno }" />
								<button type="submit" class="btn btn-outline-secondary">삭제</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>	
		<button onclick="history.back()" class="btn btn-lg btn-block btn-primary">Back</button>

		<footer>
			<nb:footer/>
		</footer>
	</div>
	
</body>
</html>