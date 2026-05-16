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
		<div class="panel-heading">BookRegister</div>
		<div class="panel-body">
			<form id="frm">
	     
			<table class="table table-hover table-bordered">
				<tr>
					<td>제목</td>
					<td><input id="bkTitle" type="text" name="bkTitle" class="form-control"></td>
				</tr>
				<tr>
					<td>작가</td>
					<td><input id="bkAuthor" type="text" name="bkAuthor" class="form-control"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input id="bkCompany" type="text" name="bkCompany" class="form-control"></td>
				</tr>
				<tr>
					<td>ISBN</td>
					<td><input id="bkIsbn" type="text" name="bkIsbn" class="form-control"></td>
				</tr>
				<tr>
					<td>분류</td>
					<td><input id="bkCategory" type="text" name="bkCategory" class="form-control"></td>
				</tr>
				<tr>
					<td>청구기호</td>
					<td><input id="bkCallNumber" type="text" name="bkCallNumber" class="form-control"></td>
				</tr>
				<tr>
					<td>도서수</td>
					<td><input id="bkCount" type="text" name="bkCount" class="form-control"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align:center">
						<button data-btn="bookRegister" type="button" class="btn btn-custom btn-sm">등록</button>
						<button type="reset" class="btn btn-default btn-sm">취소</button>	
						<button data-btn="bookList" type="button" class="btn btn-sm btn-default">목록</button>
				   </td>
			   </tr>	
			 </table>
			 
			     <!--목록에서 안넘아가는 해결방법1) 서버에서 넘겨준 객체(pageMaker)를 믿지 말고, 
			     현재 주소창에 있는 값(param)을 바로 사용해보자  -->
			 	 <input type="hidden" id="page" name="page" value="${param.page}">
				 <input type="hidden" id="perPageNum" name="perPageNum" value="${param.perPageNum}">
				 <input type="hidden" id="type" name="type" value="${param.type}">
			     <input type="hidden" id="keyword" name="keyword" value="${param.keyword}">
			     
			 </form>

			</div> 
			<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
		  </div>
		</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("button").on("click", function(e) {
				var formData = $("#frm");
				var btn = $(this).data("btn");

				if(btn == "bookList"){	
					
					//목록에서 안넘아가는 해결방법2) 
					// var page = "${param.page}";
				    // var perPageNum = "${param.perPageNum}";
				    // var type = "${param.type}";
				    // var keyword = "${param.keyword}";
				    
				    //  $("#page").val(page);
				    //  $("#perPageNum").val(perPageNum);
				    //  $("#type").val(type);
				    //  $("#keyword").val(keyword);
				    
				   //목록에서 안넘아가는 해결방법3)  
				   //location.href = "${cpath}/book/bookList?page=" + page + "&perPageNum=" + perPageNum + "&type=" + type + "&keyword=" + keyword;

				    formData.attr("action", "${cpath}/book/bookList");
					formData.attr("method", "get");
					formData.submit();
					
				}else if(btn == "bookRegister"){			
					formData.attr("action", "${cpath}/book/bookRegister");
					formData.attr("method", "post");					
					
					formData.find("#page").remove();
					formData.find("#perPageNum").remove();
					formData.submit();
					}
			});
		});
	</script>
</body>
</html>





