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
   
   #imgdiv {
      text-align:center;
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
            <li class="nav-item">
              <a class="nav-link" href="${appRoot }/admin/productlist">상품 목록</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="${appRoot }/admin/otolist">문의내역 목록<span class="sr-only">(current)</span></a>
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
      
      
      <!--  문의내역 목록 -->   
      <div class="row-12">
         <h3> 문의내역 목록 </h3>
         
         <table class="table table-striped">
              <thead>
                  <tr style="text-align :center">
                      <th style="width: 5%">#</th>
                      <th style="width: 25%">제목</th>
                      <th style="width: 35%">내용</th>
                      <th style="width: 20%">작성자</th>
                      <th style="width: 15%">작성일</th>
                  </tr>
              </thead>
              <tbody>
                 <c:forEach items="${Otolist }" var="oto" varStatus="otostatus">
                    <style>
                       #overdetail${otostatus.count}{
                        text-overflow: ellipsis;
                        overflow: hidden;
                        white-space: nowrap;
                        max-width: 35px;
                     }
                    </style>
                    <script>
                    $(document).ready(function(){
                     
                     $("#callsend${otostatus.count }").on("show.bs.modal", function(){
                        $("#content${otostatus.count }").val("");
                        
                     })
                     
                     
                     $("#sendbtn${otostatus.count }").click(function(){
                        
                        if($("#content${otostatus.count }").val()==""){
                           alert("답변내용을 입력해주세요.");
                           $("#content${otostatus.count }").focus();
                           return false;
                        }
                        
                        alert("답변을 성공적으로 보냈습니다.")
                     })
                     
                  });
                    </script>
                  <tr>
                     <td>${otostatus.count }</td>
                          <td>
                               <a type="button" class="nav-link active" id="cnbtn1" data-toggle="modal" data-target="#call${otostatus.count }">
                                  ${oto.otitle }
                        </a>
                          </td>
                     <td id="overdetail${otostatus.count}">${oto.odetail }</td>
                     <td>${oto.userid }</td>
                     <td><fmt:formatDate pattern="yyyy-MM-dd" value="${oto.oregdate }" /></td>
                  </tr>
                  
                  <!-- 문의내역 제목 클릭시 나오는 상세조회 모달 -->
                  
                  <div class="modal fade" id="call${otostatus.count }" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                     <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                           <div class="modal-header">
                              <h5 class="modal-title" id="staticBackdropLabel">${oto.userid }님의 문의내용</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                   <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                 <form>
                                    <div style="display:none;" class="form-group">
                                         <label class="control-label" for="qono">문의글 번호</label>
                                         <input value="${oto.qono }" class="form-control" type="text" name="qono" />
                                     </div>        
                                    <div class="form-group">
                                         <label class="control-label" for="otitle">제목</label>
                                         <input readonly value="${oto.otitle }" class="form-control" type="text" id="otitle${otostatus.count }" name="otitle" />
                                     </div>
                                     <div class="form-group">
                                         <label class="control-label" for="odetail">내용</label>
                                         <textarea readonly style="height:200px;" class="form-control" id="odetail${otostatus.count }" name="odetail">${oto.odetail }</textarea>
                                     </div>
                                       
                                 <div class="form-group">
                                    <label for="content" class="col-form-label">첨부파일</label>
                                    <div class="form-group" id="imgdiv">
                                          <c:if test="${not empty oto.fileName }">
                                             <c:forEach items="${oto.fileName }" var="oto_file">
                                                <div class="col-3">
                                                   <img class="img-fluid"
                                                      src="${imgRoot}oto/${oto.qono }/${oto_file}">
                                                </div>
                                             </c:forEach>
                                          </c:if>
                                    </div>
                                 </div>
                                    
                                     <div class="form-group">
                                         <label class="control-label" for="userid">작성자 </label>
                                         <input readonly value="${oto.userid }" class="form-control" type="text" id="userid${otostatus.count }" name="userid" />
                                     </div>
                                    <div class="modal-footer">
                                    <button id="callsendbtn${otostatus.count }" type="button" class="btn btn-secondary" data-toggle="modal" data-target="#callsend${otostatus.count }">답장하기</button>
                                    <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
                                    </div>
                                  </form>
                              </div>
                         </div>
                     </div>
                  </div>
                  
                  <!-- 문의내역 답장하기 모달 -->
               <div class="modal fade" id="callsend${otostatus.count }" tabindex="-1" aria-labelledby="sendModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                     <div class="modal-content">
                        <div class="modal-header">
                           <h5 class="modal-title" id="sendModalLabel">문의내역 답장하기</h5>
                           <button type="button" class="close" data-dismiss="modal"
                              aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                           </button>
                        </div>
                        <div class="modal-body">
                           <form action="${appRoot }/admin/otosend" method="post">
                              <div style="display:none;" class="form-group">
                                         <label class="control-label" for="qono">문의글 번호</label>
                                         <input value="${oto.qono }" class="form-control" type="text" id="qono${otostatus.count }" name="qono" />
                                 </div>   
                              <div class="form-group">
                                         <label class="control-label" for="otitle">제목</label>
                                         <input readonly value="${oto.otitle }" class="form-control" type="text" />
                                 </div>
                              
                              <div class="form-group">
                                         <label class="control-label" for="userid">문의 고객</label>
                                         <input readonly value="${oto.userid }" class="form-control" type="text" name="userid"/>
                                 </div>

                              <div class="form-group">
                                 <label for="content" class="col-form-label">내용</label>
                                 <textarea style="height:200px;" class="form-control" id="content${otostatus.count }" name="content"></textarea>
                              </div>
                      
                              <div class="modal-footer">
                                 <button id="sendbtn${otostatus.count }" type="submit" class="btn btn-secondary" >답장하기</button>
                                 <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
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