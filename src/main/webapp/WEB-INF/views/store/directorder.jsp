<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<%--  <%    
        int cartstock = Integer.parseInt(request.getParameter("cartstock"));

%>
 --%>

<script>
$(document).ready(function(){
	$("#spendpoint").val("");
	
	/*포인트모두사용버튼  */
	$('#useMaxPointBtn').click(function () {
 		var totalP = $('#userpoint').val();
 		$('#spendpoint').val(totalP);
 		console.log(totalP);
	});
	
	
	 /* 남은포인트 */
	 function reaminP() {
		var useP = $("#spendpoint").val();
		var authP = $("#userpoint").val();
		Number(useP);
		Number(authP);
		$('#remainPoint').val(authP - useP);
		$('.remainPoint').html(authP - useP);
	 }
	 
	$("#spendpoint").on('change',function(){
		reaminP();
	});
	$("#useMaxPointBtn").on('click',function(){
		reaminP();
	});
	
		/* 보내기전에 총금액과 사용금액이 다르면 안됨*/
		
		$('#orderSubmitBtn').click(function () {
			var authP = $('#requireTotalPrice').val();
			var useP = $('#spendpoint').val();
			if(authP != useP){
				alert("결제 금액이 다릅니다");
				return false;
			}
		
		/*보내기전에 포인트보유가 마이너스면 안됨*/
			var remainP = $('#remainPoint').val();
			Number(remainP);
			if(remainP<0){
				alert("보유금액이 부족합니다");
				return false;
			}
 		$('#form_order').submit();
	});
});	
	
</script>


<title>주문/결제하기 페이지</title>
</head>
<body>
<div class= "container">
<nb:navbar/>
<nb:scroll />
<h2>주문 페이지</h2>
<hr>

<br>
<h3>상품 목록</h3>
<hr>
<form id="form_order" action="${appRoot }/store/orderlist" method="post">
<input type = "hidden" name="pno" value = "${product.pno }">
<%-- <input type="hidden" name="cno" value = "${cart.cno }">	 --%>	
<table class="table">
    <thead class="thead-light">
    <tr>
      <th style="width:10%; text-align: center;">번호</th>
      <th style="width:15%; text-align: center;">상품명</th>
      <th style="width:40%; text-align: left;">상세설명</th>
      <th style="width:20%; text-align: center;">가격</th>
      <th style="width:15%; text-align: center;">수량</th>
    </tr>
  </thead>
  <tbody> 
        <tr>
            <th style="width:10%; text-align: center;">1</th>
            <th style="width:15%; text-align: center;">${product.title }</th>
            <td style="width:40%; text-align: left;">${product.detail }</td>
            <td id="price" style="width:20%; text-align: center;"><fmt:formatNumber  pattern="#,###원" value="${product.price}" /></td>
             <td id="cartstock" style="width:15%; text-align: center;">${cartstock }</td> 
        </tr>      

  </tbody>

   <tfoot>
       <c:set var="sum" value="${product.price * cartstock }"/>
    <tr>
        <td></td> 
		<td>주문금액 : </td>		
		<td id="sum"><fmt:formatNumber pattern="#,###원" value="${sum }" /></td>
		<td>내 보유 포인트 : </td>
		<td>${user.userpoint} 포인트</td>
    </tr>
    

  </tfoot>
</table>


<br>
<br>
<h3>배송지 정보</h3>
<hr>
  <div class="form-row">
  </div>
    <div class="form-group col-md-12">
      <label for="inputid">수령인</label>
      <input type="text" class="form-control" id="inputid" value="${user.userName }" readonly>
    </div>
  
  <div class="form-group col-md-12" >
    <label for="inputphone">연락처</label>
    <input type="text" class="form-control" id="inputphone" value="${user.userPhone }">
  </div>
  
  <div class="form-group col-md-12">
    <label for="inputAddress">주소</label>
    <input type="text" class="form-control" id="inputAddress" value="${user.useradd }">
  </div>
<br>
<br>




<%-- <input type="hidden" name="userid" value="${user.userid }">
 --%>

<div class="jumbotron">
					<h3>결제 정보</h3><br>
					<hr>
						<table class="table1">
							<tbody>
								<tr>
									<th><label for="requireTotalPrice"> 총 금액</label></th>
									<td><input id="requireTotalPrice" name="requireTotalPrice" value="${sum}"></td>
									<td><p>원  </p></td>
								</tr>								
								
								<tr>
									<th><p>보유 포인트</p></th>
									<td>
										<p class="text-right">${user.userpoint}</p>
										<input id="userpoint" value="${user.userpoint}" name="userpoint" hidden="hidden">
									</td>
									<td><p>포인트</p></td>
								</tr>
								<tr>
									<th><p>사용 포인트</th>
									<td>
										<input class="text-right" id="spendpoint" min="0" name="spendpoint" type="number" />
									</td>
									<td><p>포인트  </p></td>
									<td><button id="useMaxPointBtn" class="btn_add btn btn-primary" type="button">포인트 모두 사용</button></td>
								</tr>
								<tr>
									<th><p>결제 후 포인트</th>
									<td>
										<p class="text-right"><span class="remainPoint"></span></p>
										<input hidden="hidden" class="text-right" id="remainPoint" name="remainPoint" type="number"/>
									</td>
									<td><p>포인트</p></td>
								</tr>
							</tbody>
						</table>

</div>
		
<button type="submit" id="orderSubmitBtn" class="btn btn-lg btn-block btn-primary">주문 완료</button>
</form>
<button onclick="history.back()" class="btn btn-warning">Back</button>

	<footer>
		<nb:footer/>
	</footer>

</div>
</body>
</html>