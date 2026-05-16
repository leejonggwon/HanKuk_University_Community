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
	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	  <div class="panel panel-default">
		<div class="panel-heading">오픈채팅 - 서로 존중하는 채팅 부탁드립니다.</div>
		<div class="panel-body">
			<div style="text-align: center">
				<button class="btn btn-custom " onclick="goSocket('단체오픈채팅','${mvo.memName}(${mvo.memID})')">오픈채팅방에 입장하기</button>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
	  </div>
	</div>
	
	<script type="text/javascript">
		function goSocket(gr_id, mem_id) {
			//window.open: 새로운 브라우저
			window.open("${cpath}/chat/socketOpen?gr_id="+gr_id+"&mem_id="+mem_id, "그룹채팅","width=600px, height=800px, left=300px, top=50px");
		}
	</script>
	
</body>
</html>





