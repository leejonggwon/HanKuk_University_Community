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

	   <!-- Bootstrap 비밀번호체크 모달창 -->
	   <div class="modal fade" id="myModal" role="dialog">
	     <div class="modal-dialog">
	    
	       <!-- 모달내용-->
	       <div id="checkType" class="modal-content">
	         <div class="modal-header panel-heading"> <!-- panel-heading을 넣어야 헤더 스타일이 적용된다 -->
	           <button type="button" class="close" data-dismiss="modal">&times;</button>
	           <h4 class="modal-title">메세지 확인</h4>
	         </div>
	         <div class="modal-body">
	           <p id="checkMessage"></p> <!-- 내용 넣는부분 -->
	         </div>
	         <div class="modal-footer">
	           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	         </div>
	       </div>
	      
	     </div>
	   </div>
	
</body>
</html>