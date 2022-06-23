<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>


<title>고집 관리자페이지</title>
</head>
<style>
	.row2 label {
		display : flex;
	}
	.image_container img {
		max-width :100%;
		padding : 20px;
	}


	#adminaddbtn {
		margin: 10px;
		padding: 5px;
	}
	
	td{
		text-align:center;
		valign : middle;
	}
	
	.btn-outline-secondary{
		background-color: #ececee;
	}
	
</style>
	
<script type="text/javascript">
	$(document).ready(function(){

		//로그아웃 동작 
	    $("#navbar-logout-link").click(function(e) {
	        e.preventDefault();
	        $("#navbar-logout-form").submit();
	   	});

	});
	
	<!-- 파일 미리보기 스크립트 -->
	function setThumbnailtwo(elem) { 
		for (var image of event.target.files) { 
			var reader = new FileReader(); 
			
			reader.onload = function(event) { 
				var newCol = document.createElement("div");
				newCol.classList.add("col")
				var img = document.createElement("img"); 
				
				img.setAttribute("src", event.target.result); 
				
				newCol.appendChild(img);
				
				//document.querySelector("div.image_container").appendChild(newCol);
				$(elem).closest(".modal-body").find(".image_container").append(newCol);
			}; 
				
			
			console.log(image); 
			reader.readAsDataURL(image); 		
		} 
			
	} 
</script>
<body>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class = "container">
	
		<!-- 상단 메뉴바 -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <a class="navbar-brand" href="${appRoot}/main/home">
			<img alt="gohome-logo" width="100" src="${appRoot }/resources/img/gohomelogo22.png">
		  </a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
		    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/home">회원 목록 </a>
		      </li>
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/complist">업체 목록</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="${appRoot }/admin/productlist">상품 목록<span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/otolist">문의내역 목록</a>
		      </li>
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/adminlist">관리자 목록</a>
		      </li>
		    </ul>
		    <ul  class="navbar-nav">
				<li class="nav-item p-2">
					<span style="color:#6d0d27;"><b>현재 관리자로 로그인 중입니다</b></span>
		      	</li>
				<li class="nav-item">
       				<a class="nav-link" href="#" id="navbar-logout-link">로그아웃</a>
     			</li>
			</ul>
			<form action="${appRoot }/logout" method="post" id="navbar-logout-form"> </form>
		  </div>
		</nav>
		<hr style="border: solid 1px;">
		
		
		<!--  상품 목록 -->	
		<div class="row-12">
			<h3> 상품 목록 </h3>
			<button id="productaddbtn" type="button" class="btn btn-outline-secondary" style="float:right"
					data-toggle="modal" data-target="#productaddModal">상품 추가</button>
			<table class="table table-striped">
		        <thead>
		            <tr style="text-align :center">
		                <th style="width: 5%">#</th>
		                <th style="width: 40%">상품제목</th>
		                <th style="width: 15%">상품가격</th>
		                <th style="width: 10%">배송방법</th>
		                <th style="width: 10%">카테고리</th>
		                <th style="width: 20%">상품등록일</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach items="${Productlist }" var="product" varStatus="productstatus">
		        		<style>
		        			#overtitle${productstatus.count}{
								text-overflow: ellipsis;
								overflow: hidden;
								white-space: nowrap;
								width: 35%;
							}
		        		</style>
		        		<script>
							$(document).ready(function(){
								
								$("#call${productstatus.count }").on("show.bs.modal", function(){
									
									if("${product.delivery}" == "일반배송"){
										$("#deliveryselect${productstatus.count }").val("일반배송").prop("selected", true);
									} else{
										$("#deliveryselect${productstatus.count }").val("무료배송").prop("selected", true);
									}
									
									document.querySelector("#product-list-modal").reset();
									$(".image_container").empty();
									
								})
								
								$("#productupdbtn${productstatus.count }").click(function(){
									
									alert("수정 완료됐습니다.")
								})
								
								$("#productdelbtn${productstatus.count }").click(function(){
									$("form").attr("action", "${appRoot}/admin/productdelete");
									alert("상품을 삭제 완료됐습니다.")
								})
								
							});
							
						</script>
						<tr>
							<td>${productstatus.count }</td>
		                    <td id="overtitle${productstatus.count}">
		                   		<a type="button" class="nav-link active" id="cnbtn1" data-toggle="modal" data-target="#call${productstatus.count }">
		                   			${product.title }
								</a>
		                    </td>
							<td>${product.price }</td>
							<td>${product.delivery }</td>
							<td>${product.category }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${product.regdate }" /></td>
						</tr>
						
						<div class="modal fade" id="call${productstatus.count }" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="staticBackdropLabel">${product.title }</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						    			    <span aria-hidden="true">&times;</span>
						        		</button>
						      		</div>
						      		<div class="modal-body">
						      			<form id="product-list-modal" method="post" action="${appRoot }/admin/productupdate" enctype="multipart/form-data">
						      				<div style="display:none;" class="form-group">
								      		 	<label class="control-label" for="pno">상품 번호</label>
							                    <input value="${product.pno }" class="form-control" type="text" id="pno${productstatus.count }" name="pno" />
							                </div>		  
								      		<div class="form-group">
								      			<label class="control-label" for="image">상품 사진</label>
												<c:if test="${not empty product.fileName }">
													<div>
														<c:forEach items="${product.fileName }" var="store_file">
															
																<img class="img-fluid" src="${imgRoot}store/${product.pno }/${store_file}">
														
														</c:forEach>
													</div>
												</c:if>
											</div>
								      		<div class="form-group">
								      		 	<label class="control-label" for="stock">상품 제목</label>
							                    <input value="${product.title }" class="form-control" type="text" id="title${productstatus.count }" name="title" />
							                </div>
							                <div class="form-group">
							                 	<label class="control-label" for="stock">상품 가격</label>
							                    <input value="${product.price }" class="form-control" type="text" id="price${productstatus.count }" name="price" />
							                </div>
							                <div class="form-group row row-cols-2" >
							                <%--     <div class="col text-left">
								                	<label class="control-label" for="category">카테고리</label>
								                    <input readonly value="${product.category }" class="form-control" type="text" name="category" />
							                	</div> --%>
							                	
							                	<div class="col text-left">
									     			 <label class="control-label" for="category">카테고리 </label>
										      		 <select disabled name="category" >
										      			 <option>${product.category } </option>
										      		 </select>
											    </div>
											    
										  <!--   </div> -->
										    	
							                	<div class="col text-right">
								                    <label class="control-label" for="adddelivery">배송 방법</label>
									                <select id="deliveryselect${productstatus.count }" name="delivery">
							                    		<option value="무료배송">무료배송</option>
							                    		<option value="일반배송">일반배송</option>
							                    	</select>
							                    </div>
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="detail">상세설명 </label>
							                    <textarea style="height:200px;" class="form-control" id="detail${productstatus.count }" name="detail">${product.detail }</textarea>
							                </div>
							                <div class="form-group">
												<label for="store_file">파일</label>
												<input id="store_file${productstatus.count }" class="form-control" type="file" name="store_file" multiple="multiple" accept="image/*" onchange="setThumbnailtwo(this);">
											</div>
											<div>파일 미리보기</div>
												<div class="jumbotron jumbotron-fluid">
													<div class="container">
														<div class="row row-cols-2 image_container" >
															<!-- 이미지 불러오는곳  -->
												  		</div>
													</div>
												</div>
												
								      		<div class="modal-footer">
												<button id="productdelbtn${productstatus.count }" type="submit" class="btn btn-danger mr-auto">삭제</button>
												<button id="productupdbtn${productstatus.count }" type="submit" class="btn btn-primary">수정</button>
												<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
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
		
		
		<script>
			$(document).ready(function(){
				
				$("#productaddModal").on("show.bs.modal", function(){
					/*
					$("#addtitle").val("");
					$("#addprice").val("");	
					$("#deliveryselect").val("무료배송");
					$("#categoryselect").val("가구");	
					$("#adddetail").val("");
					*/
					document.querySelector("#product-add-modal-form").reset();
					$(".image_container").empty();

				})
				
				$("#signbtn").click(function(){
					
					alert("상품등록이 완료됐습니다.")
				})
			});
		
		</script>
						
		<!-- 상품 추가 버튼 클릭시 나오는 모달 -->
		<div class="modal fade" id="productaddModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="productaddModaltitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="productaddModaltitle">상품 추가</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form id="product-add-modal-form" class="col-12" action="${appRoot }/admin/productlist" method="post" enctype="multipart/form-data">
		        	<div class="form-group" style="display:none;">
	                    <label class="control-label" for="addwriter">작성자</label>
	                    <input class="form-control" type="text" id="addwriter" name="userid" value="${uservo.userid }"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="addtitle">상품 제목</label>
	                    <input class="form-control" type="text" id="addtitle" name="title" />
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="addprice">상품 가격</label>
	                    <input class="form-control" type="text"  id="addprice" name="price"/>
	                </div>
	                <div class="form-group row row-cols-2" >
	                    <div class="col text-left">
		                	<label class="control-label" for="category">카테고리</label>
	                		<select id="categoryselect" name="category">
		                    	<option value="가구">가구</option>
		                    	<option value="수납">수납</option>
		                    	<option value="조명">조명</option>
		                    	<option value="가전">가전</option>
		                    	<option value="장식/소품">장식/소품</option>	
		                    </select>
	                	</div>
	                	<div class="col text-right">
		                    <label class="control-label" for="adddelivery">배송 방법</label>
			                <select id="deliveryselect" name="delivery">
	                    		<option value="무료배송">무료배송</option>
	                    		<option value="일반배송">일반배송</option>
	                    	</select>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="adddetail">상세설명</label>
	                    <textarea style="height:200px;" class="form-control" id="adddetail" name="detail"></textarea>
	                </div>
 					<div class="form-group">
						<label for="store_file">파일</label>
						<input id="store_file" class="form-control" type="file" name="store_file" multiple="multiple" accept="image/*" onchange="setThumbnailtwo(this);">
					</div>
					<div>파일 미리보기</div>
						<div class="jumbotron jumbotron-fluid">
							<div class="container">
								<div class="row row-cols-2 image_container" >
									<!-- 이미지 불러오는곳  -->
						  		</div>
							</div>
						</div>
	                 
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-primary" id="signbtn">상품 추가</button>
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			      </div>
	          	  </form>
		      </div>
		    </div>
		  </div>
		</div>				
		
		
		
		
		
		
		
		
		
		
		
		
	</div>
	</sec:authorize>
	<script>
	$(document).ready(function(){
		$("#returnbtn").click(function(){
			location.href="${appRoot }/main/home"; 
		})	
	})
	</script>
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<div class = "container">
		<nb:navbar></nb:navbar>
		<h1 style="text-align:center"> 이곳은 고집 관리자페이지 입니다.</h1>
		<h3 style="text-align:center"> 접근 권한이 없습니다.</h3>
			<div style="text-align:center">
				<button id=returnbtn type="button" style="width:400px; height:100px; margin:0 auto;"><span style="font-size:30px">고홈 돌아가기</span></button>
			</div>
	</div>
	</sec:authorize>
</body>
</html>