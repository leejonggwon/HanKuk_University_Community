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
		<div class="panel-heading">보낸메일</div>
		<div class="panel-body">
		<form id="frm">							
			<button data-btn="deleteMsg" class="btn btn-default btn-sm pull-left" style="margin: 0px 0px 15px 5px;"">삭제</button> 
			<button data-btn="msgRecordList" class="btn btn-custom btn-sm pull-left" style="margin: 0px 0px  15px 5px;">
				<span class="glyphicon glyphicon-send"></span>&nbsp; 보낸 메세지함 이동
			</button> 	
			
			<table class="table table-bordered table-hover">									 	
				<tr>
					<td style="text-align: center; vertical-align: middle; width: 15%;">제목</td>
					<td><c:out value="${vo.msgTitle}"/></td>
				</tr>
				<tr>
					<td id="fromID" style="text-align: center; vertical-align: middle;">수신자 아이디</td>
					<td>${vo.toID}</td>
				</tr>
				<tr>
					<td id="msgContent" style="text-align: center; vertical-align: middle;">내용</td>
					<td>
						<textarea class="form-control" readonly="readonly" rows="8" cols=""><c:out value="${vo.msgContent}"/></textarea>					
					</td>
				</tr>			
				
				<c:if test="${not empty vo.attached_data}">
					<tr>
						<td style="text-align: center">다운로드링크</td>
						<td><a id="attached_data" href="${cpath}/message/download/${vo.attached_data}">${vo.attached_data}</a></td>
					</tr>			
				</c:if>
				
						
				</table>
				
				<input id="toID" type="hidden" name="toID" value="${vo.fromID}">
				<input type="hidden" name="msgIdx" value="${vo.msgIdx}">
				
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
			attached_dataName(); //첨부파일 이름 보기좋게
		});
		
		$("button").on("click", function() {
			var formData = $("#frm");
			var btn = $(this).data("btn"); //data-btn
			if(btn == "msgRecordList"){
				formData.attr("action", "${cpath}/message/msgRecordList");
				formData.attr("method", "get");
			}else if(btn =="deleteMsg"){
				formData.attr("action", "${cpath}/message/RecordDeleteMsg");
				formData.attr("method", "post");				
				formData.find("#toID").remove();
			}
			formData.submit();
		});
		
		//첨부파일이름 조정
		function attached_dataName(){	
			var attached_data = $("#attached_data").text();
		
			if (attached_data.includes("_")) { 
				new_attached_data = attached_data.substring(attached_data.indexOf("_") + 1);
  			}
			
			$("#attached_data").text(new_attached_data);
		}

	</script>
	
	
</body>
</html>





