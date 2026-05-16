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
		<div class="panel-heading">발권정보</div>
		<div id="nowRview" class="panel-body">
		<div>나의자리</div>
		<br>
		<table class="table table-bordered table-hover"> 
			<tr class="active">
				<td style="text-align: center">현재 발권된 좌석이 없습니다.</td>		
			</tr>	
			<tbody>	
			</tbody>
						
		</table>

		</div>
		
		<div class="panel-body">
		<div>사용이력</div>
		<br>
		
			<div class="table-responsive" style="max-height: 400px;"> <!-- 스크롤기능 -->
				<table class="table table-bordered table-hover"> 
					<tr class="active">
						<td style="text-align: center">NO</td>
						<td style="text-align: center">좌석번호</td>
						<td style="text-align: center">좌석이름</td>
						<td style="text-align: center">발권시간</td>
						<td style="text-align: center">반납시간</td>		
						<td style="text-align: center">사용자</td>		
					</tr>
					<tbody id="recordView">
					<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->			
					</tbody>
				</table>	
			</div>
				
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
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
				listHtml += "<div>나의자리</div>";
				listHtml += "<br>";
				listHtml += "<table class='table table-bordered table-hover'>";
				listHtml += "<tr class='active'>";
				listHtml += "<td style='text-align: center'>현재 발권된 좌석이 없습니다.</td>";		
				listHtml += "</tr>";
				listHtml += "<tbody>";
			    listHtml += "</tbody>";			  
			
			    listHtml += "</table>";
				
			}else{
				
				listHtml += "<div>나의자리</div>";
				listHtml += "<br>";
				listHtml += "<table class='table table-bordered table-hover'>";
				listHtml += "<tr class='active'>";
				listHtml += "<td style='text-align: center'>좌석번호</td>"; 
				listHtml += "<td style='text-align: center'>좌석이름</td>";
				listHtml += "<td style='text-align: center'>발권시간</td>";
				listHtml += "<td style='text-align: center'>사용자</td>";
				listHtml += "</tr>";
				listHtml += "<tbody>";
				listHtml += "<tr>";
			    listHtml += "<td style='text-align: center'>" + vo.seatNum + "</td>";
			    listHtml += "<td style='text-align: center'>" + vo.seatName + "</td>";
			    listHtml += "<td style='text-align: center'> " + formatted + "</td>";
			    listHtml += "<td style='text-align: center'>" + vo.memName + "</td>";		    
			    listHtml += "</tr>";	
			    listHtml += "</tbody>";			  
			    listHtml += "<tr>";	
			    listHtml += "<td colspan='4' align='center'>";	
			    listHtml += "<button onclick='returnSeat()' class='btn btn-custom btn-sm'>좌석반납하기</button>";	
			    listHtml += "</td>";	
			    listHtml += "</tr>";
			    listHtml += "</table>";
			    
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
				var formatted_startTime = startTime.getFullYear() + "년 " +
							(startTime.getMonth()+1).toString().padStart(2,'0') + "월 " +
				            startTime.getDate().toString().padStart(2,'0') + "일  " +
				            startTime.getHours().toString().padStart(2,'0') + "시 " +
				            startTime.getMinutes().toString().padStart(2,'0') + "분 " +
				            startTime.getSeconds().toString().padStart(2,'0') + "초 ";
				
				var endTime = new Date(vo.endTime); 
				var formatted_endTime = 							            
				            startTime.getHours().toString().padStart(2,'0') + "시 " +
				            startTime.getMinutes().toString().padStart(2,'0') + "분 " +
				            startTime.getSeconds().toString().padStart(2,'0') + "초 ";
				
				
				listHtml += "<tr>";
				listHtml += "<td style='text-align: center'>" + (index+1) + "</td>";
				listHtml += "<td style='text-align: center'>" + vo.seatNum + "</td>";
				listHtml += "<td style='text-align: center'>" + vo.seatName + "</td>";
				listHtml += "<td style='text-align: center'>" + formatted_startTime + "</td>";
				listHtml += "<td style='text-align: center'>" + formatted_endTime + "</td>";
				listHtml += "<td style='text-align: center'>" + vo.memName + "</td>";		
				listHtml += "</tr>";

			});
			
			$("#recordView").html(listHtml);	
			
			}
		
			//좌석반납하기
			//seatAvailable 1 → 0
			function returnSeat(){
				
			  if(!confirm("반납 하시겠습니까?")) {
			        return; 
			    }
			  
				var seatNum = "${rvo.seatNum}";
			
			    $.ajax({
			        url: "${cpath}/seat/returnSeatAvailable0",
			        type: "post",
			        data: { "seatNum": seatNum },		      
			        success: function() {
			        	 //alert("seatAvailable 1 → 0 성공");
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
			        	 //alert("memStatus 1 → 0 성공");
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
			        	 //alert( "endTime 성공");	
			        	 alert( "반납 되었습니다.");				        	 
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





