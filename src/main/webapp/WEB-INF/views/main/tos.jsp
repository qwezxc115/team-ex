<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
	<title>회원가입 약관동의 </title>
	
	
	<style type="text/css">
		*{ margin: 0;padding: 0;}
		body{ background-color: #ececee;}
		ul>li{ list-style: none}
		a{ text-decoration: none;}
	
		
		#joinForm{ margin: 0 auto;}
		.join_box{ border: 1px solid #ddd;background-color: #fff;}
		.checkBox,.checkBox>ul{ position: relative;}
		.checkBox>ul>li{ float: left;}
		.lsfl{ width:100%;}
		.libl{ width:100%;}
		.spchk{ color:#6d0d27;}
		.checkBox>ul>li:first-child{ width:100%;padding:10px;font-weight: 600;color: #888;}
		.checkBox>ul>li:nth-child(2){ position: absolute;top: 50%;right: 30px;margin-top: -12px;}
		.checkBox .form-control{ padding:10px;background-color: #f7f7f7;color: #888; border: none;}
		.footBtwrap{ margin-top: 15px;}
		.footBtwrap>li{ float: left;width: 50%;height: 60px;}
		.footBtwrap>li>button{ display: block; width: 100%;height: 100%; font-size: 20px;text-align: center;line-height: 60px;}
		.fpmgBt1{ background-color: #fff;color:#888;border: 1px solid #ddd;}
		.fpmgBt2{ background-color: #fff;color:#888;border: 1px solid #ddd;}
		.lp{ padding:0 10px;color:#888;}
	</style>
	
	
	<script>
		$(document).ready(function(){
			$(".fpmgBt2").css({"background-color": "#fff", "color": "#888"}).prop("disabled",true);
			$("input[type=checkbox]").prop("checked",false);
			
		  	$("#checkall").click(function(){
		
		        if($("#checkall").prop("checked")){
		            $("input[class=chk]").prop("checked",true);
					$(".fpmgBt2").css({"background-color": "#daccc6", "color": "#000"}).prop("disabled",false);
		        } else{
		            $("input[class=chk]").prop("checked",false);
					$(".fpmgBt2").css({"background-color": "#fff", "color": "#888"}).prop("disabled",true);
		        }
		    });
		    
			$('.chk').click(function(){		
				var Btnlengths = $(".chk").length;
				var Btnchecks = $('.chk:checked').length;
				var chk1 = $("#chk1").prop("checked");
				var chk2 = $("#chk2").prop("checked");
				
				if (Btnlengths == Btnchecks){
					$("#checkall").prop("checked", true);
				} else {
					$("#checkall").prop("checked", false);
				}
				
				if(chk1 && chk2 == true){
					$(".fpmgBt2").css({"background-color": "#daccc6", "color": "#000"}).prop("disabled",false);
				} else {
					$(".fpmgBt2").css({"background-color": "#fff", "color": "#888"}).prop("disabled",true);
				}
			});
			
			$("#notBt").click(function(){
				location.href="${appRoot}/main/home"; 
	
			});
			
		});
		
	</script>
</head>
<body>
	<div class = "container">
		<div class="text-center p-3">
              <a href="${appRoot }/main/home">
              <img alt="gohome" width="150" src="${appRoot }/resources/img/gohomelogo22.png"></a>
        </div>
		<form action="${appRoot }/main/signup" id="joinForm">
			<div class="join_box p-3">
			
				<div class="m-2 p-2">
					<h3>
					주식회사 고집
					<br>
					서비스 약관에 동의해 주세요.
					</h3>
				</div>
				<ul class="clearfix">
	                <li class="checkBox check01">
	                    <ul class="lsfl">
	                         <li class="libl">
	                         	전체동의는 필수 및 선택정보에 대한 동의도 포함되어 있으며, 
	                         	개별적으로도 동의를 선택하실 수 있습니다. <br>
	                         	선택항목에 대한 동의를 거부하시는 경우에도 서비스는 이용이 가능합니다.
	                         </li>
	                         
	                        <li>
	                        	<label for="checkall"> <b class="p-3">모두 동의합니다</b> </label>
	                            <input type="checkbox" id="checkall">
	                        </li>
	                    </ul>
	                </li>
				</ul>
				<hr>
           		<ul>
                <li class="checkBox check02">
                    <ul class="clearfix">
                        <li>이용약관 동의 <span class="spchk">(필수)</span></li>
                        <li class="checkBtn">
                            <input type="checkbox" class="chk" id= "chk1"> 
                        </li>
                    </ul>
                    
                    <textarea class="form-control" rows="3" readonly="readonly" >여러분을 환영합니다.
고집 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 고집  서비스의 이용과 관련하여 고집 서비스를 제공하는 고집  주식회사(이하 ‘고집 ’)와 이를 이용하는 고집  서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
      				 </textarea>
                </li>
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>개인정보 수집 및 이용에 대한 안내 <span class="spchk">(필수)</span></li>
                        <li class="checkBtn">
                            <input type="checkbox" class="chk" id= "chk2">
                        </li>
                    </ul>
                    <textarea class="form-control" rows="4" readonly="readonly" >개인정보보호법에 따라 고집에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다
</textarea>
                </li>
                
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>위치정보 이용약관 동의 (선택)</li>
                        <li class="checkBtn">
                            <input type="checkbox" class="chk">
                        </li>
                    </ul>
 
                    <textarea class="form-control" rows="3" readonly="readonly" >위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.
제 1 조 (목적)
이 약관은 고집  주식회사 (이하 “회사”)가 제공하는 위치정보사업 또는 위치기반서비스사업과 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
</textarea>
                </li>
                
                <li class="checkBox check04">
                    <ul class="clearfix">
                        <li>이벤트 등 프로모션 알림 메일 수신 (선택)</li>
                        <li class="checkBtn">
                            <input type="checkbox" class="chk">
                        </li>
                    </ul>
                    <p class="lp">
                    고집에서 제공하는 이벤트/혜택 등 다양한 정보를 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 고집  가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.
                    </p>
                </li>
            </ul>
            </div>
            <ul class="footBtwrap clearfix">
                <li><button class="fpmgBt2" type="submit">동의</button></li>
                <li><button class="fpmgBt1" id="notBt" type="button">비동의</button></li>
            </ul>
        </form>
	</div>
</body>
</html>