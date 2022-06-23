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

<title>Q&#38;A </title>
<style type="text/css">
	
	.top_bg{ 
		width: 100%;
	    height: 100px;
	
    }
    .list-group .list-group-item.active, .list-group .show>.list-group-item {background-color: #6d0d27;}
 	.list-group{
  		flex-direction: inherit;
  	}
 	.list-group-item{
  		border:none;
  	}

    .table{
   	 	min-height:500px;
    }
    .Q_title{
    	cursor:pointer;
    }
    .answer{
    	 display:none;
    }
   
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		
		$(".Q_title").click(function() {
			
			$(".answer").slideUp();
		
			$(".fa-chevron-down").css('transform','none');
			if(!$(this).next().is(":visible")){
				
				$(this).next().slideDown();
				$(this).find(".fa-chevron-down:eq(0)").css('transform','rotate(180deg)');
			}
		});
		
		
	})

</script>
</head>
<body>
<div class="container">	
		
	<nb:navbar/>
	<nb:scroll />	

		<div class="top_bg text-center ">
		
			<h3 class="p-4">Q&#38;A </h3>
			
		</div>			  

		
		<div class="">
		    <div class="row row-cols-3 list-group text-center" id="list-tab" role="tablist">
		      <a class="col list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">회원정보 </a>
		      <a class="col list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">주문/결제</a>
		      <a class="col list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages"> 배송관련 </a>
		    </div>
			    <div class="tab-content" id="nav-tabContent">
			      	<div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
			      		<table class="table">
			      			<tbody >
								<tr class="d-flex flex-column">
									<td >
										<h5 class="Q_title">Q 비밀번호 변경은 어떻게하나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 비밀번호 변경이 가능합니다.</p>
									</td>
									<td>
										<h5 class="Q_title">Q 회원탈퇴 후 재가입이 가능한가요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">재가입은 언제든지 가능합니다.</p>
									<td>
										<h5 class="Q_title">Q 회원정보를 수정하고 싶은데 어떻게 해야하나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 회원 정보 수정이 가능합니다.</p>
									</td>
								</tr>
							</tbody>
			      		</table>
					 </div>
					 
				      <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
		      			<table class="table">
			      			<tbody >
								<tr class="d-flex flex-column">
									<td >
										<h5 class="Q_title">Q 비밀번호 변경은 어떻게하나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 비밀번호 변경이 가능합니다.</p>
									</td>
									<td>
										<h5 class="Q_title">Q 회원탈퇴 후 재가입이 가능한가요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">재가입은 언제든지 가능합니다.</p>
									<td>
										<h5 class="Q_title">Q 회원정보를 수정하고 싶은데 어떻게 해야하나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 회원 정보 수정이 가능합니다.</p>
									</td>
									<td>
										<h5 class="Q_title">Q 비회원주문 및 전화주문이 가능한가요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">전화주문은 준비중에 있습니다. <br>비회원 주문은 가능하지만 일부 상품에 한해 제한되어있습니다.</p>
									</td>
								</tr>

							</tbody>
			      		</table>
				      </div>
				      
				      <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
			      		<table class="table">
			      			<tbody >
				
								<tr class="d-flex flex-column">
									<td >
										<h5 class="Q_title">Q 배송비는 얼마인가요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">판매 업체 별로 배송비 정책이 상이합니다각 상품상세페이지에서 배송비를 확인하실 수 있습니다.</p>
									</td>
									<td>
										<h5 class="Q_title">Q 배송은 얼마나 걸리나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">
											상품 배송 기간은 배송 유형에 따라 출고 일자 차이가 있습니다.자세한 사항은 구매하신 상품의 상세 페이지에서 확인 가능하며, 배송 유형 별 기본 출고 기간은 아래와 같습니다.<br>
												∙ 일반 택배 / 화물 택배 : 결제 후 1~3 영업일 이내 출고됩니다.<br>
												∙ 업체 직접 배송 : 배송 지역에 따라 배송 일자가 상이할 수 있으므로 상품 상세 페이지에서 확인 해주세요.<br>
												※ 영업일은 주말, 공휴일을 제외한 기간입니다.<br>
												※ 제조사의 사정에 따라 출고일은 지연될 수 있는 점 양해 부탁드립니다.<br>
										</p>
									<td>
										<h5 class="Q_title">Q 원하는 날짜로 맞춰서 배송을 받을수 있나요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">각 배송처 정책에 따라 상이할 수 있습니다.</p>
									</td>
									<td>
										<h5 class="Q_title">Q 해외배송이 가능한가요? <i class="fas fa-chevron-down"></i></h5>
										<p class="answer">현재는 국내배송만 진행하고 있습니다.</p>
									</td>
								</tr>
							</tbody>
			      		</table>
				      </div>
			    </div>
		</div>

	<footer>
		<nb:footer></nb:footer>
	</footer>
	
</div>
</body>
</html>