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
		<div class="panel-heading">Board</div>
		<div class="panel-body">
			<form id="frm"> 	
			<table class="table table-hover table-bordered">
			<input id="memID" type="hidden" name="memID" value="${mvo.memID}">
			<input id="memMajor" type="hidden" name="memMajor" value="${mvo.memMajor}">
						
				<tr>
					<td>카테고리</td>
					<td>
						<div class="form-inline justify-content-start"> 
							<select id="category" name="category" class="form-control">
								<option value="">카테고리</option>
						        <option value="일상">일상</option>	
							        <option value="학교생활">학교생활</option>					        
						        <option value="질문">질문</option>
						        <option value="스터디모집">스터디모집</option>
						        <option value="동아리">동아리</option>
						        <option value="홍보">홍보</option>
						        <option value="취업진로">취업진로</option>
						        <option value="거래나눔">거래나눔</option>
							</select>
						</div>	
					</td>
				</tr>	
				<tr>
					<td>제목</td>
					<td><input required id="title" type="text" name="title" class="form-control"></td>
				</tr>	
				<tr>	
					<td>내용</td>
					<td><textarea required id="content" rows="10" cols="" name="content" class="form-control"></textarea></td>
				</tr>
				<tr>
					<td>이미지업로드</td>
					<td><input type="file" id="uploadFile_img" name="imgpath" accept="image/*" class="form-control"></td>
				</tr>	
				<tr>
					<td>첨부파일</td>
					<td><input type="file" name="attached_data" class="form-control"></td>
				</tr>			
				<tr>
					<td>작성자</td>
					<td><input id="writer" type="text" name="writer" class="form-control" value="${mvo.memName}" readonly="readonly"></td>
				</tr> 
				<tr>
					<td colspan="2" style="text-align:center">
						<button data-btn="register" type="button" class="btn btn-custom btn-sm">등록</button>
						<button type="reset" class="btn btn-default btn-sm">취소</button>
						<button data-btn="list" type="button" class="btn btn-sm btn-default">목록</button>
					</td>
				</tr>	
			</table>
			
			
			
		</form>
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
	  </div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("button").on("click", function(e) {
				var formData = $("#frm");
				//alert(formData);
				//alert(formData[0]); //DOM 객체
				
				var btn = $(this).data("btn");
				
				if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove();
					formData.attr("method", "get");
					
					formData.find("#memID").remove();
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();	
								
					
				}else if(btn == "register"){
					
					var file = $("#uploadFile_img")[0].files[0];
					var category = $("#category").val();	
	  				
	  				if(!category){
	  					alert("카테고리를 선택해주세요");
	  					$("#category").focus();
	  					return false; 
	  				}
	  				
	  				// *먼저 파일이 있을 때만 영상 파일인지 체크해야한다	
	  			    if (file) {         
	  			        if (!file.type.startsWith("image/")) {
	  			            alert("'이미지첨부'는 이미지 파일만 등록할 수 있습니다");
	  			            $("#uploadFile_img").val(""); 
	  			            return false; 
	  			        }
	  			    }
	  				
	  				
	  				
					
					formData.attr("action", "${cpath}/board/register");
					formData.attr("method", "post");
					formData.attr("enctype", "multipart/form-data");		
					
					formData.find("#page").remove();
					formData.find("#perPageNum").remove();
					
					var formEl = formData[0]; //jQuery 객체에서 진짜 DOM 요소를 꺼내는 것

					//checkValidity(): required 검사 통과했는지 확인하는 함수
					if (!formEl.checkValidity()) { //올바르게 입력하면 true 이지만 !이므로→ false
					    formEl.reportValidity();   //경고를 띄운다
					    return;
					};
				}
				formData.submit();
			});
		});
	</script>
	
</body>
</html>
