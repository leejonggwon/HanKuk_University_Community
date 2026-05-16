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
		<div class="panel-heading">자료검색 - 소장자료 및 구독자료를 검색하세요.</div>
		<div class="panel-body">
		<div style="text-align:center">
			<form class="form-inline" action="${cpath}/book/bookList" method="post"> 
				<div class="form-group">
					<select name="type" class="form-control">
						<option value="bkTitle" ${pageMaker.cri.type=='bkTitle' ? 'selected' : ''} >도서명</option> 						
						<option value="bkAuthor" ${pageMaker.cri.type=='bkAuthor' ? 'selected' : ''} >작가</option>
						<option value="bkCompany" ${pageMaker.cri.type=='bkCompany' ? 'selected' : ''} >출판사</option>
					</select>
				</div>	
				<div class="form-group">
					<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
				</div>
				<button type="submit" class="btn btn-sm btn-custom" style="margin: 0px 5px 0px 0px;">도서검색</button>	
				
				<br>
				<br>
				<p style="text-align: center">※검색어 없이 도서 검색 버튼을 누르면 전체 도서가 출력됩니다</p>												
			</form>
		</div>
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
	  </div>
	</div>
	
	<script type="text/javascript">

	</script>
	
</body>
</html>





