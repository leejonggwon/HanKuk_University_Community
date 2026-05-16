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
			<div class="panel-heading">Update Profile</div>
			<div class="panel-body">
					
			<form id="imageUpdateForm"> <!-- 이미지나 영상 이런걸로 보낼때는 인코딩방식을 바꿔줘야한다 		                                                                                               기본적으로 text보내는 형식에서 → multipart/form-data 형식으로 바꿔줘야한다 -->
			<input type="hidden" name="memID" id="memID" value="${mvo.memID}" > 
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">			
					<tr><!-- 사진업로드 -->
						<td style="width: 110px; vertical-align: middle;">프로필 이미지</td>						
						<td>
							<span class="btn btn-default">
								이미지를 업로드하세요 <input type="file" name="memProfile" id="memProfile" accept="image/*" >
							</span>
						</td>		
					</tr>				
					<tr>
						<td colspan ="2">		
						<div class="pull-right">
							<button type="button" data-oper="imageUpdate" class="btn btn-custom" id="memProfileBtn" disabled>이미지등록</button>			
							<button type="button" data-oper="imageDelete" class="btn btn-defult">삭제</button>															
						</div>
						</td>
					</tr>				
				</table>
			</form>


			<form action="${cpath}/member/update" method="post"> <!-- controller위치는 views 바로 아래에 있다 -->
				<input type="hidden" name="memID" id="memID" value="${mvo.memID}" > 
				
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					<tr>
						<td style="width: 150px; vertical-align: middle;">학번</td>
						<td>${mvo.memID}</td>								
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">권한</td>
						<td>${mvo.memRole}</td>								
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">회원코드</td>
						<td>${mvo.memUserCode}</td>								
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">학과</td>
						<td>${mvo.memMajor}</td>								
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">이름</td>
						<td>${mvo.memName}</td>								
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">나이</td>
						<td>${mvo.memAge} 세</td>								
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">성별</td>
						<td>${mvo.memGender}</td>								
					</tr>

					<tr>
						<td style="width: 110px; vertical-align: middle;">이메일</td>
						<td colspan ="3"><input value="${mvo.memEmail}" type="email" name="memEmail" id="memEmail" class="form-control" maxlength="50" placeholder="이메일을 입력하세요"></td>				
					</tr>
					
					<tr>
						<td colspan ="3">
							
							<input type="submit" class="btn btn-custom btn" value="이메일수정">					
						</td>
					</tr>
					
				</table>
			</form>
			
			
			<form id="passwordUpdateForm" > <!-- controller위치는 views 바로 아래에 있다 -->
				<input type="hidden" name="memPassword" id="memPassword" value="" > 
				<input type="hidden" name="memID" id="memID" value="${mvo.memID}" > 
				<%-- 회원정보 수정할때 이미지가 날아가는것 방지하는 두번째 방법 --%>
				<%-- <input type="hidden" name="memProfile" id="memProfile" value="${mvo.memProfile}" >  --%>
				
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호</td>
						<td colspan ="2"><input required="required" type="password" onkeyup="passwordCheck()" name="memPassword1" id="memPassword1" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>					
						<!-- onkeyup: 키보드에서 손을 뗄 때 발생하는 이벤트 -->
						<!-- required="required" 유효성검사속성, 반드시 입력해야한다 라는 제약을 걸어주는 속성 -->
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
						<td colspan ="2"><input type="password" onkeyup="passwordCheck()" name="memPassword2" id="memPassword2" class="form-control" maxlength="20" placeholder="비밀번호를 확인하세요"></td>					
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호일치</td>
						<td colspan ="2">
							<span id="passMessage2"></span> <!-- 비밀번호 일치 여부 메시지 표시-->												
						</td>
					</tr>
					<tr>
						<td colspan ="3">
							<button type="button" data-oper="passwordUpdate" class="btn btn-custom">비밀번호수정</button>	
						</td>
					</tr>
					
				</table>
			</form>
			
			
			
			
			</div>
			<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
		</div>
	</div>
	
   <%@ include file="/WEB-INF/views/common/check_modal.jsp" %> 
   
   <!-- 업데이트 실패시 띄워줄 모달창 -->
      <!--회원가입 성공시 띄워줄 모달창 -->
   <%@ include file="/WEB-INF/views/common/message_modal.jsp" %>
   
	
	<script type="text/javascript">
	
	//회원가입 실패시 띄워줄 모달창 실행
	//HTML 문서가 모두 로딩될 때까지 기다렸다가 그 안의 기능을 실행하겠다는 의미 
	$(document).ready(function(){
		
		if(${not empty msgType}){ //EL식		
			if(${msgType eq "성공메세지"}){ //EL식
				$("#messageType").attr("class", "modal-content panel-primary");
			}else{
				$("#messageType").attr("class", "modal-content panel-warning");
			}
		$("#myMessage").modal("show"); //모달창 실행
		}
		

	  $("button[data-oper]").on("click", function(){
	  		const oper = $(this).data("oper"); 	  		
	  		const imageUpdateForm = $("#imageUpdateForm");	  		
	  		const passwordUpdateForm = $("#passwordUpdateForm");
	  		
		    if(oper == "imageUpdate"){   
		    	
 			    var file = $("#memProfile")[0].files[0];
	 			// *먼저 파일이 있을 때만 영상 파일인지 체크해야한다	
	 			    if (file) {         
	 			        if (!file.type.startsWith("image/")) {
	 			            alert("'프로필이미지'는 이미지 파일만 등록할 수 있습니다");
	 			            $("#uploadFile_img").val(""); 
	 			            return false; 
	 			        }
	 			    }
		    	
			    imageUpdateForm.attr("action", "${cpath}/member/imageUpdate");
			    imageUpdateForm.attr("method", "post");			   
			    imageUpdateForm.attr("enctype", "multipart/form-data");     
			    imageUpdateForm.submit();   	
			  
		   }else if (oper == "imageDelete"){
			   
			   if(!confirm("프로필 이미지를 삭제하시겠습니까?\n삭제 후에는 기본 이미지로 변경됩니다")) {
			        return; //취소를 누르면 함수종료 된다
			    }	    
			   imageUpdateForm.attr("action", "${cpath}/member/imageDelete");
			   imageUpdateForm.attr("method", "post");			        
			   imageUpdateForm.submit();
			   
		   }else if (oper == "passwordUpdate"){
			      
			   if(!confirm("비밀번호를 변경하시겠습니까?\n변경 후에는 자동으로 로그아웃됩니다.")) {
			        return; //취소를 누르면 함수종료 된다
			    }	 

			   passwordUpdateForm.attr("action", "${cpath}/member/passwordUpdate");
			   passwordUpdateForm.attr("method", "post");			        
			   passwordUpdateForm.submit();   	   
		   }
		});
	}); //ready
	
	
	
		const memProfile = document.getElementById("memProfile");
	    const memProfileBtn = document.getElementById("memProfileBtn");
	    
	    memProfile.addEventListener("change", function() {
	        if(memProfile.files.length > 0) {
	        	memProfileBtn.disabled = false; // 파일 선택되면 활성화
	        } else {
	        	memProfileBtn.disabled = true;  // 파일 없으면 비활성화
	        }
	    });	
	
		
		//비밀번호체크
		function passwordCheck() {
			var memPassword1 = $("#memPassword1").val();
			var memPassword2 = $("#memPassword2").val();
			
			if(memPassword1 != memPassword2){
				$("#passMessage2").html("비밀번호가 서로 일치하지 않습니다")
				$("#passMessage2").css("color", "red");
				$("#memPassword").val("");
			}else{
				$("#passMessage2").html("비밀번호가 서로 일치합니다")
				$("#passMessage2").css("color", "blue");
				
				//2개가 일치했을 때, 입력한 비밀번호가 hidden태그의 value에 값이 들어간다
				$("#memPassword").val(memPassword2); 
			}		
		}
		

		
	</script>
	
</body>
</html>
