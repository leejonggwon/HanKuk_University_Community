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
<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
</head>
<body>
	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	  <div class="panel panel-default">
		<div class="panel-heading">Board Edit</div>
		<div class="panel-body">
		 	<form id="frm">
				<table class="table table-bordered table-hover">
					<tr>
						<td>카테고리</td>
						<td>
							<div class="form-inline justify-content-start"> 
								<select id="category" name="category" class="form-control">			
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
						</td>
					</tr>	
					<tr>
						<td>번호</td>
						<td><input id="idx" readonly="readonly" value="${vo.idx}" name="idx" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input id="title" value="<c:out value='${vo.title}'/>" name="title" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea id="content" name="content" class="form-control" rows="10" cols=""><c:out value="${vo.content}"/></textarea>
						</td>
					</tr>
					
					<!-- vo.imgpath 값이 비어 있다면 -->
					<c:if test="${not empty vo.imgpath}"> 
						<tr>
							<td>이미지파일 삭제</td>			
							<td><button id="imgpathDeleteBtn" type="button" class="btn btn-sm btn-primary" onclick="deleteAttachedImgpath()">${vo.imgpath}</button></td>
						</tr>
					</c:if>
					
					<!-- vo.attached_fule 값이 비어 있다면 -->
					<c:if test="${not empty vo.attached_data}"> 
						<tr>
							<td>첨부파일 삭제</td>			
							<td><button id="attached_dataDeleteBtn" type="button" class="btn btn-sm btn-primary" onclick="deleteAttached_data()">${vo.attached_data}</button></td>
						</tr>
					</c:if>	

					<tr>
						<td>이미지업로드</td>
						<td><input id="file" type="file" name="imgpath" accept="image/*" class="form-control"></td>
					</tr>	
					
					<tr>
						<td>첨부파일</td>
						<td><input id="file" type="file" name="attached_data" class="form-control"></td>
					</tr>	
					<tr>
						<td>작성자</td>
						<td><input id="writer" readonly="readonly" value="${vo.writer}" name="writer" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center">
							<!-- 로그인한 상태이고 로그인한 사람과 아이디와 게시글 쓴사람 아이디가 일치하면 수정삭제 버튼기능 활성화한다-->
							<button data-btn="modify" type="button" class="btn btn-sm btn-custom">수정</button>	
							<button data-btn="get" type="button" class="btn btn-sm btn-default">조회페이지</button>				      					       
							<button data-btn="list" type="button" class="btn btn-sm btn-default">목록</button>
						</td>
					</tr>
				</table>
				
				<!-- 이미지 --> 
				<input type="hidden" name="originImgpath" value="${vo.imgpath}">
				<!-- 첨부파일 --> 
				<input type="hidden" name="originAttached_data" value="${vo.attached_data}">
				
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">				
			  	<input type="hidden" id="type" name="type" value="${cri.type}">
			  	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">	
				
			</form>
			
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
	  </div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			
			$("button[data-btn]").on("click", function (e) {
				var formData = $("#frm");
				var btn = $(this).data("btn");
				
				if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove(); //목록으로 갈때는 idx가 필요가 없다
					formData.attr("method", "get");
					
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();			
					
				}else if(btn == "modify"){
					
					// var page = "${param.page}";
				    // var perPageNum = "${param.perPageNum}";
				    // var type = "${param.type}";
				    // var keyword = "${param.keyword}";
				    
				    //  $("#page").val(page);
				    //  $("#perPageNum").val(perPageNum);
				    //  $("#type").val(type);
				    //  $("#keyword").val(keyword);
				    
					formData.attr("action", "${cpath}/board/modify");
					formData.attr("method", "post");
					formData.attr("enctype", "multipart/form-data"); //파일업로드
					
				}else if(btn == "get"){ //조회페이지
					formData.attr("action", "${cpath}/board/get");
					formData.attr("method", "get");
				}
				formData.submit();
			});
			
		
			imgpathName();
			attached_dataName();
			
		}); //ready
		
		
		//이미지첨부파일 삭제기능
		function deleteAttachedImgpath(){		
			$("#frm").find("input[name='originImgpath']").remove();	
			alert("첨부된 이미지 삭제되었습니다");		
			$("#imgpathDeleteBtn").attr("class", "btn btn-sm btn-default").text("이미지파일 삭제 완료");
		}
		
		//첨부파일 삭제기능
		function deleteAttached_data(){		
			$("#frm").find("input[name='originAttached_data']").remove();	
			alert("첨부된 파일 삭제되었습니다");		
			$("#attached_dataDeleteBtn").attr("class", "btn btn-sm btn-default").text("첨부파일 삭제 완료");
		}
		
		

		//이미지명 조정
		function imgpathName(){	
			var imgpath = $("#imgpathDeleteBtn").text();
			
			if (imgpath.includes("_")) { // Java의 contains 대신 includes 사용
				imgpath = imgpath.substring(imgpath.indexOf("_") + 1);
  			}
			
			$("#imgpathDeleteBtn").text(imgpath);
		}
		
		//첨부파일명
		function attached_dataName(){	
			var attached_data = $("#attached_dataDeleteBtn").text();
		
			if (attached_data.includes("_")) { 
				new_attached_data = attached_data.substring(attached_data.indexOf("_") + 1);
  			}
			
			$("#attached_dataDeleteBtn").text(new_attached_data);
		}
	</script>
	
</body>
</html>





