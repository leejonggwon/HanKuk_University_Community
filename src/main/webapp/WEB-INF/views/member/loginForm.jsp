<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 --> 
<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HanKuk University Community</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
 
</head>
<body>
		
	<div class="container" style="margin-top: 200px;">
	<div class="row" style="display: flex; align-items: center;">

	<!-- 좌측-->
	<div class="col-md-7">
		<img src="${cpath}/resources/images/hku_main.png" style="max-width:100%; height:auto;">
	</div>

	<!-- 우측  -->
	<div class="col-md-5">

		<div style="border:1px solid #ddd; padding:40px; border-radius:10px; background-color:white; box-shadow:0 2px 10px rgba(0,0,0,0.08);">

		<div style="text-align: center;">
		    <img src="${cpath}/resources/images/hku_community.png" style="width:100%; height:auto; ">
		</div>

		<form action="${cpath}/member/loginProcess" method="post">

	
			<div class="form-group">					
				<input type="text" name="memID" id="memID" class="form-control" maxlength="20" placeholder="학번을 입력해주세요">
			</div>
	
			<div class="form-group" style="margin-top:20px;">					
				<input required="required" type="password" name="memPassword" id="memPassword" class="form-control" maxlength="20" placeholder="비밀번호를 입력해주세요">
			</div>
	
			<div style="margin-top:25px;">
				<span id="passMessage"></span>
				<input type="submit" class="btn btn-custom btn-block" value="로그인">
			</div>

		</form>

		</div>

	</div>

	</div>
</div>

 	<%@ include file="/WEB-INF/views/common/message_modal.jsp" %>
	<%@ include file="/WEB-INF/views/common/check_modal.jsp" %>
   
	<script type="text/javascript">	
		//회원가입 실패시 띄워줄 모달창 실행
		//HTML 문서가 모두 로딩될 때까지 기다렸다가 그 안의 기능을 실행하겠다는 의미 
		$(document).ready(function(){
			
			if(${not empty msgType}){ //EL식
				if(${msgType eq "실패메세지"}){ //EL식
					$("#messageType").attr("class", "modal-content panel-warning");
				}else{
					$("#messageType").attr("class", "modal-content panel-success");
				}
				$("#myMessage").modal("show"); //모달창 실행
		});
		
		
		
		
	</script>
	
</body>
</html>

