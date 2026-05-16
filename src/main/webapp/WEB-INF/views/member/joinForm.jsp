<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->

<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
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
	<br>
	<br>
	<div class="container">
		
		<div class="panel panel-default">
			<div class="panel-heading">Sign up</div>
			<div class="panel-body">
			
			<form action="${cpath}/member/join" method="post"> <!-- controller위치는 views 바로 아래에 있다 -->
				<input type="hidden" name="memPassword" id="memPassword" value="" > <!-- 실질적으로 이값을 넘길것이다 -->
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					<tr>
						<td style="width: 110px; vertical-align: middle;">아이디</td>
						<td><input required="required" type="text" name="memID" id="memID" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>
						<td style="width: 110px;"><button type="button" onclick="registerCheck()" class="btn btn-primary">중복확인</button></td>						
					</tr>
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
						<td style="width: 200px; vertical-align: middle;">비밀번호일치 여부 확인</td>
						<td colspan ="2" style="text-align: center">
							<span id="passMessage"></span> <!-- 비밀번호 일치 여부 메시지 표시-->															
						</td>
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">사용자이름</td>
						<td colspan ="2"><input required="required" type="text" name="memName" id="memName" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>				
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">나이</td>
						<td colspan ="2"><input required="required" type="number" name="memAge" id="memAge" class="form-control" maxlength="20" placeholder="나이를 입력하세요"></td>				
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">성별</td>
						<td colspan ="2">
							<div class="form-group" style="text-align: center; margin:0 auto">
								<div class="btn-group" data-toggle="buttons"> 
									<label class="btn btn-primary active">
										<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자" checked="checked"> 남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여자"> 여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">이메일</td>
						<td colspan ="2"><input required="required" type="email" name="memEmail" id="memEmail" class="form-control" maxlength="50" placeholder="이메일을 입력하세요"></td>				
					</tr>
					<tr>
						<td colspan ="3" style="text-align: center">
							<span id="passMessage"></span> <!-- 비밀번호 일치 여부 메시지 표시-->						
							<input type="submit" class="btn btn-primary" value="등록">
							<input type="reset" class="btn btn-warning" value="취소">						
							<a href="${cpath}/" class="btn btn-success">로그인폼</a>				
						</td>
					</tr>
					
				</table>
			</form>
			</div>
			<div class="panel-footer">MVC Communication - All rights reserved</div>
		</div>
	</div>
	
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
   
   <!-- 회원가입 실패시 띄워줄 모달창 -->
   <div class="modal fade" id="myMessage" role="dialog">
     <div class="modal-dialog">
     
       <!-- 모달내용-->
       <div id="messageType" class="modal-content">
         <div class="modal-header panel-heading"> <!-- panel-heading을 넣어야 헤더 스타일이 적용된다 -->
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">${msgType}</h4> <!--MemberController에서 실패하면 joinForm에서 다시 이동할때 값을 보내준다 -->
         </div>
         <div class="modal-body">
           <p>${msg}</p> 
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>
   
     </div>
   </div>
   

	<script type="text/javascript">
	
		//아이디 중복확인
		function registerCheck() {
			var memID = $("#memID").val(); //val(): 입력한 값을 가져온다  
			
			$.ajax({
				url:"${cpath}/member/registerCheck", 
														
				type:"post",
				data:{"memID": memID},
				success:function(data){ //data결과값 받아온다
					//중복유무확인 → (data=1 사용가능, data=0 사용불가능)
					if(data == 1){
						$("#checkMessage").text(memID +"는사용할 수 있는 아이디 입니다");
						$("#checkType").attr("class", "modal-content panel-success");
					}else{
						$("#checkMessage").text("사용할 수 없는 아이디 입니다");
						$("#checkType").attr("class", "modal-content panel-warning");
					}
					$("#myModal").modal("show"); //.modal() 함수는 Bootstrap의 JavaScript 플러그인에서 제공하는 함수다
				},
				error: function(){ alert("아이디 중복확인 기능 error"); }
			});
		}
		
		//비밀번호체크
		function passwordCheck() {
			var memPassword1 = $("#memPassword1").val();
			var memPassword2 = $("#memPassword2").val();
			
			if(memPassword1 != memPassword2){
				$("#passMessage").html("비밀번호가 서로 일치하지 않습니다")
				$("#passMessage").css("color", "red");
			}else{
				$("#passMessage").html("비밀번호가 서로 일치합니다")
				$("#passMessage").css("color", "blue");
				
				//2개가 일치했을 때, 입력한 비밀번호가 hidden태그의 value에 값이 들어간다
				$("#memPassword").val(memPassword2); 
			}		
		}
		
		//회원가입 실패시 띄워줄 모달창 실행
		//HTML 문서가 모두 로딩될 때까지 기다렸다가 그 안의 기능을 실행하겠다는 의미 
		$(document).ready(function(){
			if(${not empty msgType}){ //EL식
				if(${msgType eq "실패메세지"}){ //EL식
					$("#messageType").attr("class", "modal-content panel-warning");
				}
			$("#myMessage").modal("show"); //모달창 실행
			}
		});
		
		
	</script>
	
</body>
</html>
