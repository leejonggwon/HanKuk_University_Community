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
		<div class="panel-heading">Board Reply</div>
		<div class="panel-body">
			<form id="frm"> 
				
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
				<input type="hidden" id="type" name="type" value="${cri.type}">
			  	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
				
				<input id="memMajor" type="hidden" name="memMajor" value="${mvo.memMajor}">
				<input id="category" type="hidden" name="category" value="${vo.category}">
				<input id="memID" type="hidden" name="memID" value="${mvo.memID}">
				<!-- 부모글의 게시글 번호를 넘긴다 -->
				<input id="idx" type="hidden" name="idx" value="${vo.idx}">
				
				
				<div class="form-group" >
					<label>분류</label>
					
					<div class="form-inline justify-content-start"> 
						<select disabled id="category" name="category" class="form-control">			
							<option value="">카테고리</option>			
					        <option value="일상"
					        ${vo.category == '일상' ? 'selected' : ''}>
					        일상
					        </option>
					
					        <option value="학교생활"
					        ${vo.category == '학교생활' ? 'selected' : ''}>
					        학교생활
					        </option>
					
					        <option value="질문"
					        ${vo.category == '질문' ? 'selected' : ''}>
					        질문
					        </option>
					
					        <option value="스터디모집"
					        ${vo.category == '스터디모집' ? 'selected' : ''}>
					        스터디모집
					        </option>
					
					        <option value="동아리"
					        ${vo.category == '동아리' ? 'selected' : ''}>
					        동아리
					        </option>
					
					        <option value="홍보"
					        ${vo.category == '홍보' ? 'selected' : ''}>
					        홍보
					        </option>
					
					        <option value="취업진로"
					        ${vo.category == '취업진로' ? 'selected' : ''}>
					        취업진로
					        </option>
					
					        <option value="거래나눔"
					        ${vo.category == '거래나눔' ? 'selected' : ''}>
					        거래나눔
					        </option>			
						</select>
					</div>				
				</div>
				
				<div class="form-group" >
					<label>제목</label>
					<input id="title" type="text" name="title" class="form-control" placeholder="제목을 입력하세요">
				</div>
				<div class="form-group" >
					<label>답글</label>
					<textarea id="content" class="form-control" name="content" rows="10" cols="" placeholder="답글을 입력하세요"></textarea>
				</div>
				
				<div class="form-group" >
					<label>이미지파일</label>
					<input type="file" name="imgpath" class="form-control">
				</div> 
				
				<div class="form-group" >
					<label>첨부파일</label>
					<input type="file" name="attached_data" class="form-control">
				</div> 

				<div class="form-group" >
					<label>작성자</label>
					<input id="writer" value="${mvo.memName}" readonly="readonly" type="text" name="writer" class="form-control">
				</div> 
				
				<div style="text-align:center">
					<button data-btn="reply" type="button" class="btn btn-custom btn-sm">답글등록</button>
					<button data-btn="reset" type="button" class="btn btn-default btn-sm">취소</button>
					<button data-btn="get" type="button" class="btn btn-sm btn-default">조회페이지</button>
					<button data-btn="list" type="button" class="btn btn-default btn-sm">목록</button>   	
				</div>
		  	  				       		
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
				
				if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove();
					formData.attr("method", "get");
					
					formData.find("#memID").remove();
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();	
				}else if(btn == "reply"){			
					formData.attr("action", "${cpath}/board/reply");
					formData.attr("method", "post");
					formData.attr("enctype", "multipart/form-data");
				}else if (btn == "reset") {
					formData[0].reset();
					//<form> 태그를 가져와서 초기값으로 되돌린다
					
					return; //함수끝내는 키워드
				}else if(btn == "get"){
					formData.attr("action", "${cpath}/board/get");
					formData.attr("method", "get");
				}
				formData.submit();
			});
		});
	</script>
	
</body>
</html>





