<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<!DOCTYPE html>
<html>
<head>

<%@ include  file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<script>
$(document).ready(function(){
	
		$('#orderSubmitBtn').click(function () {
			
			if($("#cartlist").val()==null){
				alert("구매할 상품이 없습니다");
				return false;
			}
			$('#form_order').submit();
		});	 		
	});	
	
</script>

<title>장바구니</title>
</head>
<body>
<div class= "container">
<nb:navbar/>
<nb:scroll />

<h2>장바구니</h2>
<hr>

 <form id="form_order" action="${appRoot }/store/order" method="post">
<table class="table">
   
    <thead class="thead-light">
    <tr>
      <th style="width:5%; text-align: center;">번호</th>
      <th style="width:15%; text-align: center;">상품명</th>
      <th style="width:40%; text-align: left;">상세설명</th>
      <th style="width:10%; text-align: center;">가격</th>
      <th style="width:10%; text-align: center;">수량</th>
      <th style="width:10%; text-align: center;">합계</th>
      <th style="width:10%; text-align: center;">취소</th>
    </tr>
  </thead>
  
  <tbody>
    <c:forEach var="cart" items="${cart}" varStatus="status">

<script>
$(document).ready(function() {
	var deleteUrl = "${appRoot }/store/cartdelete";
	$("#cart-delete-btn${status.count}").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			$("form").attr("action", deleteUrl);
			$("form").submit();
		} else {
			
			return false;
		}
	});

});

</script>
    
<input name = "cno" type ="hidden" value = "${cart.cno }"/>
        <tr>     	
            <th id="cartlist" style="width:5%; text-align: center;">${status.count }</th>
            <th style="width:15%; text-align: center;">${cart.title }</th>
            <td style="width:40%; text-align: left;">${cart.detail }</td>
            <td style="width:10%; text-align: center;"><fmt:formatNumber pattern="#,###원" value="${cart.price}" /></td>
            <td style="width:10%; text-align: center;">${cart.cartstock }</td>
            <td style="width:10%; text-align: center;"><fmt:formatNumber pattern="#,###원" value="${cart.money}" /></td>
            <td style="width:10%; text-align: center;">
			<button type="submit" id="cart-delete-btn${status.count}" class="btn btn-outline-secondary" >삭제</button>

            </td>
        </tr>  

    </c:forEach>
  </tbody>
  
   <tfoot>
    <tr>
        <td colspan="4"></td> 
		<td>주문금액 : </td>		
		<td><fmt:formatNumber pattern="#,###원" value="${sumMoney}" /></td>
		<td colspan="1"></td>
    </tr>
  </tfoot>

</table>
<button type="submit" id="orderSubmitBtn" class="btn btn-lg btn-block btn-primary" >주문하기</button>

<i class="fas fa-arrow-left"></i><button onclick="history.back()"class="btn btncl" >HOME</button>	
</form>
	
<br>	
<br>	
	
	<footer>
		<nb:footer/>
	</footer>
	
</div>
</body>
</html>