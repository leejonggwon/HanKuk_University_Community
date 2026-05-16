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
	<!-- 작성자 정보를 띄워줄 모달 -->
	<div class="modal fade" id="writerModal" role="dialog">
	  <div class="modal-dialog">  
	    <div class="modal-content panel-primary" id="writerType">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">작성자 정보</h4>
	      </div>
	      
	      <div class="modal-body text-center">
	        <img id="writerImg" src="" style="width:120px; height:120px; border-radius:50%; margin-bottom:10px;">     
	       
	        <p id="writerID" style="font-size:16px;"></p>           
	        <p id="writerName" style="font-size:16px;"></p>
	        <p id="writerMajor" style="font-size:16px;"></p>
	        <p id="writerUserCode" style="font-size:16px;"></p>
	        
	        <button id="regBtnProfile" class="btn btn-custom btn-sm">메세지 보내기</button>
	      </div>
	      
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</body>
</html>