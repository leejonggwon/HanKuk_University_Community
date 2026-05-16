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
		<div class="panel-heading">BookContent</div>
		<div class="panel-body">
		<form id="frm">
			<table class="table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td><input id="bkNum" readonly="readonly" value="${vo.bkNum}" name="bkNum" class="form-control"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input id="bkTitle" readonly="readonly"  value="${vo.bkTitle}" name="bkTitle" class="form-control"></td>
				</tr>
				<tr>
					<td>작가</td>
					<td><input id="bkAuthor" readonly="readonly"  value="${vo.bkAuthor}" name="bkAuthor" class="form-control"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input id="bkCompany" readonly="readonly"  value="${vo.bkCompany}" name="bkCompany" class="form-control"></td>
				</tr>
				<tr>
					<td>ISBN</td>
					<td><input id="bkIsbn" readonly="readonly"  value="${vo.bkIsbn}" name="bkIsbn" class="form-control"></td>
				</tr>
				<tr>
					<td>분류</td>
					<td><input id="bkCategory" readonly="readonly"  value="${vo.bkCategory}" name="bkCategory" class="form-control"></td>
				</tr>
				<tr>
					<td>청구기호</td>
					<td><input id="bkCallNumber" readonly="readonly"  value="${vo.bkCallNumber}" name="bkCallNumber" class="form-control"></td>
				</tr>
				<tr>
					<td>도서수</td>
					<td><input id="bkCount" value="${vo.bkCount}" name="bkCount" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<button data-btn="bookUpdate" type="button" class="btn btn-sm btn-custom">수정</button>
						<button data-btn="bookDelete" type="button" class="btn btn-sm btn-default">삭제</button>   									      					       
						<button data-btn="bookList" type="button" class="btn btn-sm btn-default">목록</button>
					</td>
				</tr>
			
				</table>
				
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">	
				<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
			  	<input type="hidden" id="type" name="type" value="${cri.type}">
			  	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
				
			</form>
			
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
	  </div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			$("button").on("click", function() {
				var formData = $("#frm");
				var btn = $(this).data("btn"); //data-btn
				if(btn == "bookDelete"){
					formData.attr("action", "${cpath}/book/bookDelete");
					formData.attr("method", "get");
					
					formData.find("#bkTitle").remove();
					formData.find("#bkAuthor").remove();
					formData.find("#bkCompany").remove();
					formData.find("#bkIsbn").remove();
					formData.find("#bkCategory").remove();
					formData.find("#bkCallNumber").remove();
					formData.find("#bkCount").remove();	
					
				}else if(btn == "bookList"){
					formData.attr("action", "${cpath}/book/bookList");
					formData.attr("method", "get");
					
					formData.find("#bkNum").remove();
					formData.find("#bkTitle").remove();
					formData.find("#bkAuthor").remove();
					formData.find("#bkCompany").remove();
					formData.find("#bkIsbn").remove();
					formData.find("#bkCategory").remove();
					formData.find("#bkCallNumber").remove();
					formData.find("#bkCount").remove();
					
				}else if(btn == "bookUpdate"){
					formData.attr("action", "${cpath}/book/bookUpdate");
					formData.attr("method", "post");
				}
				formData.submit();
			});
			
		});

	</script>
	
</body>
</html>





