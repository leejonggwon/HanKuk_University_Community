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
</head>
<body>


	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	  <h2>HanKuk University Community</h2>
	  <div class="panel panel-default">
		<div class="panel-heading">Board</div>
		<div class="panel-body">
		<div>나의자리</div>
		<br>
				<table class="table table-bordered table-hover"> 
					<tr class="active">
						<td>좌석번호</td>
						<td>좌석이름</td>						
						<td>발권시간</td>	
						<td>사용자</td>	
					</tr>
					
					<tbody id="nowRview">
					<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->			
					</tbody>
					
					<!-- 로그인 했을때만 글쓰기 버튼이 보이게 한다(session에 mvo가 있으면 로그인한 상태) -->
					
					<tr>
						<td colspan="4" align="center"> <!-- colspan="5": 5개의 열을 합쳐서 한 줄에 걸쳐 표시 -->
							<button onclick="returnSeat()" class="btn btn-primary ">좌석반납하기</button>
						</td>
					</tr>					
				</table>

		</div>
		
		<div class="panel-body">
		<div>사용이력</div>
		<br>
			<table class="table table-bordered table-hover"> 
				<tr class="active">
					<td>NO</td>
					<td>좌석번호</td>
					<td>좌석이름</td>
					<td>발권시간</td>
					<td>반납시간</td>		
					<td>사용자</td>		
				</tr>
				<tbody id="recordView">
				<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->			
				</tbody>
			</table>		
		</div>
		<div class="panel-footer">MVC Communication - All rights reserved</div>
	  </div>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {
		nowRInfo();
		rRecord();
	});
		
	
	
	//현재 발권정보만 출력
	function nowRInfo(){
		var memID = "${mvo.memID}";
		
	    $.ajax({
	        url: "${cpath}/seat/nowRInfo",
	        type: "post",
	        data: { "memID": memID },
	        dataType: "json", 
	        success: function(vo) {
	        	nowRview(vo);
	        }, 
	        error: function() {}
	    });
		}
		
		//현재 발권정보
		//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 게시글의 정보를 받아온다
		function nowRview(vo){
			
			var startTime = new Date(vo.startTime); 
			var formatted = startTime.getFullYear() + "년 " +
			            (startTime.getMonth()+1).toString().padStart(2,'0') + "월 " +
			            startTime.getDate().toString().padStart(2,'0') + "일  " +
			            startTime.getHours().toString().padStart(2,'0') + "시 " +
			            startTime.getMinutes().toString().padStart(2,'0') + "분 " +
			            startTime.getSeconds().toString().padStart(2,'0') + "초 ";
			                
			var listHtml = "";	
			if(vo.seatNum == null){
				
			}else{
				listHtml += "<tr>";
			    listHtml += "<td>" + vo.seatNum + "</td>";
			    listHtml += "<td>" + vo.seatName + "</td>";
			    listHtml += "<td> " + formatted + "</td>";
			    listHtml += "<td>" + vo.memName + "</td>";		    
			    listHtml += "</tr>";	
			}
			    
			$("#nowRview").html(listHtml);	
		}

		
		//발권기록 출력
		function rRecord(){
			var memID = "${mvo.memID}";
			
		    $.ajax({
		        url: "${cpath}/seat/rRecord",
		        type: "post",
		        data: { "memID": memID },
		        dataType: "json", 
		        success: function(data) {
		        	recordView(data); 
		        },	      	
		        error: function() {}
		    });
			}
		
		//사용이력출력
		function recordView(data){
			var listHtml = "";
			
			//jQuary반목문
			$.each(data, function(index, vo){ //index:순서 표시자
				
				var startTime = new Date(vo.startTime); 
				var formatted = startTime.getFullYear() + "." +
							(startTime.getMonth()+1).toString().padStart(2,'0') + "월 " +
				            startTime.getDate().toString().padStart(2,'0') + "일  " +
				            startTime.getHours().toString().padStart(2,'0') + "시 " +
				            startTime.getMinutes().toString().padStart(2,'0') + "분 " +
				            startTime.getSeconds().toString().padStart(2,'0') + "초 ";
				
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td>" + vo.seatNum + "</td>";
				listHtml += "<td>" + vo.seatName + "</td>";
				listHtml += "<td> " + formatted + "</td>";
				listHtml += "<td>" + vo.endTime + "</td>";
				listHtml += "<td>" + vo.memName + "</td>";		
				listHtml += "</tr>";

			});
			
			$("#recordView").html(listHtml);	
			
			}
		
			//좌석반납하기
			//seatAvailable 1 → 0
			function returnSeat(){
				var seatNum = "${rvo.seatNum}";
			
			    $.ajax({
			        url: "${cpath}/seat/returnSeatAvailable0",
			        type: "post",
			        data: { "seatNum": seatNum },		      
			        success: function() {
			        	 alert("seatAvailable 1 → 0 성공");
			        	 returnMemStatus0();
			        },	      	
			        error: function() {
			            alert("seatAvailable 1 → 0 실패");
			        }
			    });
				}
			
			//memStatus 1 → 0
			function returnMemStatus0(){
				var memID = "${mvo.memID}";
			
			    $.ajax({
			        url: "${cpath}/seat/returnMemStatus0",
			        type: "post",
			        data: { "memID": memID },		      
			        success: function() {
			        	 alert("memStatus 1 → 0 성공");
			        	 endTime();
			        },	      	
			        error: function() {
			            alert("memStatus 1 → 0 실패");
			        }
			    });
				}
			
			
			
			//반납시간넣기 
			function endTime(){		
				var seatNum = "${rvo.seatNum}";
				var memID = "${mvo.memID}";
			
			    $.ajax({
			        url: "${cpath}/seat/endTime",
			        type: "post",
			        data: { "seatNum": seatNum, "memID" : memID },		      
			        success: function(vo) {
			        	 alert( "endTime 성공");	
			        	 nowRview(vo);
			        	 rRecord();		  
			        },	      	
			        error: function() {
			            alert("endTime 실패");
			        }
			    });
				}	

			
			
		


	</script>
	
</body>
</html>





