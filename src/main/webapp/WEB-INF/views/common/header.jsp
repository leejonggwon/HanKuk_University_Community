<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--JSTL Core 라이브러리: JSP에서 조건문, 반복문, 변수 설정 등을 할 때 사용, 자바 코드 대신 JSTL 문법으로 표현 가능 -->     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!-- JSTL Functions(함수) 라이브러리: 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--JSTL Formatting라이브러리: fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!-- ${cpath}/login/loginProcess 이렇게 쓰인다  -->



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HanKuk University Community</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	
	<!-- div class="container" -->
	<div class="container-fluid" style="padding-left: 260px; padding-right: 260px;">
	<!-- 정적 include 이라서 WEB-INF 안에 있는 JSP를 직접 읽어올 수 있다 -->
	
	<!-- 메뉴바 -->
	<nav class="navbar navbar-default">
		<div class="container-fluid">
		
			<div class="navbar-header">		
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				
				<a class="navbar-brand" href="#"><span style=" margin-left:25px; margin-right:5px;">HanKuk University</span></a>
			</div>
				
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="#"><a href="${cpath}/board/list/">커뮤니티</a></li> <!--루트(/)만 입력하면 controller(context path)가 생략되므로, 명시적으로 /controller/를 입력 -->
					<li><a href="${cpath}/chat/chatGroup/">오픈채팅</a></li>
					<li><a href="${cpath}/seat/seat/">좌석발권</a></li>
					<li><a href="${cpath}/seat/rInfo/">발권정보</a></li>		
					<li><a href="${cpath}/book/bookSearch/">자료검색</a></li>		
				</ul>	
				
		
				<!-- 로그인된 사용자(세션이 유효한 경우)에게 보여주는 영역  --> 
				<c:if test="${not empty mvo}"> <!-- mvo로 session을 꺼내기로 했다 -->
				<ul class="nav navbar-nav navbar-right">
				
					<c:if test="${not empty mvo.memProfile}">
					    <li>				    	
					        <img style="width:50px; height:50px;" class="img-circle" alt="" src="${cpath}/profile_upload/${mvo.memProfile}" />
					   		<span style="padding-left:5px;">${mvo.memName} (${mvo.memID})</span>
					    </li>
					</c:if>
					
					<c:if test="${empty mvo.memProfile}">
					    <li>				    	
					        <img style="width:50px; height:50px;" class="img-circle" alt="" src="${cpath}/resources/images/default.png" /> 
					    	<span style="padding-left:5px;">${mvo.memName} (${mvo.memID})</span>
					    </li>
					</c:if>
					<li><a href="${cpath}/message/msgList"><span class="glyphicon glyphicon-envelope"></span>&nbsp;메세지&nbsp;<span id="newMsgCount" class="badge"></span></a></li>

					<li><a href="${cpath}/member/updateForm"><span class="glyphicon glyphicon-edit"></span>&nbsp;회원정보수정</a></li>
					
					<li><a href="${cpath}/member/logoutProcess"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>								
				</ul>
				
				
				</c:if>
				
			</div>
		</div>
	</nav>
	
	<script type="text/javascript">
		$(document).ready(function(){
			newMsgCount();
		});
		
		//새 매세지갯수
		function newMsgCount(){
			var toID = "${mvo.memID}";
			
			$.ajax({
				url : "${cpath}/message/newMsgCount",    
				type: "get",      
				data : {"toID" : toID},
				dataType: 'json',
				success: function(data){
					if(data > 0){
						$("#newMsgCount").text(data);
			        }
				},
				error: function(){alert("새매세지 불러오기 실패");}
			});
		};
		

	</script>
	
</body>
</html>