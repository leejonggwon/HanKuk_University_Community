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
		<div class="panel-heading">메세지 쓰기</div>
		<div class="panel-body">
		<form id="frm">
		
			<button data-btn="sendMsg" type="button" class="btn btn-custom btn-sm pull-left" style="margin: 0px 0px 15px 0px;">보내기</button>
			<button type="reset" class="btn btn-default btn-sm pull-left" style="margin: 0px 0px  15px 5px;">취소</button>	
			<button data-btn="msgList" type="button" class="btn btn-default btn-sm pull-left" style="margin: 0px 0px 15px 5px;">
			<span class="glyphicon glyphicon-folder-open"></span>&nbsp; 받은 메세지함 이동
			</button>
			
			<table class="table table-hover table-bordered">
			
			<input type="hidden" id="page" name="page" value="${cri.page}">
			<input type="hidden" id="perPageNum" name="perPageNum" value="${cri.perPageNum}">
			<input type="hidden" id="type" name="type" value="${cri.type}">
			<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
			
			<input type="hidden" id="fromName" name="fromName" value="${mvo.memName}">
			<input type="hidden" id="fromMajor" name="fromMajor" value="${mvo.memMajor}">
			
				<tr>
					<td style="text-align: center; vertical-align: middle;">받는사람</td>
					<td><input type="text" name="toID" id="toID" class="form-control" maxlength="20" value="${toID}"></td>
					<td style="width: 110px;"><button type="button" onclick="registerCheck()" class="btn btn-custom">중복확인</button></td>
				</tr>
				<tr>
					<td style="text-align: center; vertical-align: middle;">제목</td>
					<td colspan ="2"><input id="msgTitle" name="msgTitle" type="text" class="form-control"></td>				
				</tr>
				<tr>
					<td style="text-align: center; vertical-align: middle;">파일첨부</td>
					<td colspan ="2"><input id="file" name="attached_data" type="file"  class="form-control"></td>
				</tr>
				<tr>
					<td style="text-align: center; vertical-align: middle;">내용</td>
					<td colspan ="2"><textarea  id="msgContent" name="msgContent" rows="10" clols=""  class="form-control"></textarea></td>
				</tr>		
				<tr>
					<td style="text-align: center; vertical-align: middle;">보낸사람</td>
					<td colspan ="2"><input readonly="readonly" id="fromID" name="fromID" type="text" value="${mvo.memID}" class="form-control"></td>
				</tr>	
			 </table>
			 </form>
		
			
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
	  </div>
	</div>
	
	<!-- Bootstrap 아이디체크 모달창 -->
   <div class="modal fade" id="myModal" role="dialog">
     <div class="modal-dialog">
    
       <!-- 모달내용-->
       <div id="checkType" class="modal-content">
         <div class="modal-header panel-heading"> 
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">메세지 확인</h4>
         </div>
         <div class="modal-body">
           <p id="checkMessage"></p> 
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>
      
     </div>
   </div>
   
   

	<script type="text/javascript">
	
	    //**button 전체에 이벤트 걸려 있어서 중복확인 버튼까지 submit 됨 → AJAX 모달이 안 뜬다
		//따라서 이벤트 대상을 button → "button[data-btn]" 으로 좁혀서 해결한다
		$("button[data-btn]").on("click", function(e) {
			var formData = $("#frm");
			var btn = $(this).data("btn");
			
			if(btn == "msgList"){
				formData.attr("action", "${cpath}/message/msgList");
				formData.attr("method", "get");
				
				formData.find("#toID").remove();
				formData.find("#msgTitle").remove();
				formData.find("#msgImgpath").remove();
				formData.find("#msgContent").remove();	
				formData.find("#fromID").remove();
	
			}else if(btn == "sendMsg"){			
				formData.attr("action", "${cpath}/message/sendMsg");
				formData.attr("method", "post");	
				formData.attr("enctype", "multipart/form-data");

				}
			formData.submit();
		});
			
	    
		//아이디중복확인
		function registerCheck() {
			var memID = $("#toID").val();
			
			$.ajax({
				url:"${cpath}/member/registerCheck", 										
				type:"post",
				data:{"memID": memID},
				success:function(data){ 	
					if (data == 1) {
		                $("#checkMessage").text("해당 아이디는 존재하지 않습니다.");
		                $("#checkType").attr("class", "modal-content panel-danger");
		            }
		            else {
		                $("#checkMessage").text(memID + " 님에게 메시지를 보낼 수 있습니다.");
		                $("#checkType").attr("class", "modal-content panel-primary");
		            }
					$("#myModal").modal("show"); //.modal() 함수는 Bootstrap의 JavaScript 플러그인에서 제공하는 함수다
				},
				error: function(){ alert("아이디 중복확인 기능 error"); }
			});
		}
	</script>
	
</body>
</html>





