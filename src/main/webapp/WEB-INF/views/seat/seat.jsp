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
	 
	  <div class="panel panel-default">
		<div class="panel-heading">좌석발권</div>
		<div style="text-align: center" class="panel-body">	
		<br>
			<c:forEach items="${seatInfo}" var="vo" varStatus="i">
				<c:choose>
					<c:when test="${vo.seatAvailable == 0}">	
							<button type="button" class="btn btn-default" onclick="seatAvailable(${vo.seatNum})">
						        <c:out value="${vo.seatName}"/>
						    </button>							
					</c:when>		
					
					<c:otherwise>
						<button disabled="disabled" type="button" class="btn btn-default" onclick="seatAvailable(${vo.seatNum})">
					        <c:out value="${vo.seatName}"/>
					    </button>
					</c:otherwise>				
				</c:choose>
				
			    <c:if test="${i.index % 10 == 9}"> <!-- 10개씩 버튼 나눈다 -->
			        <br/><br/>
			    </c:if>
			</c:forEach>
			<button disabled="disabled" class="btn btn-dark" type="button"><span class="glyphicon glyphicon-arrow-up"></span>&nbsp; 열람실 입구</button>
			<br>	
		
	
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
	  </div>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {
		
	});
	

	//좌석발권
	//Seat테이블 seatAvailable 0 → 1 변경하기
	function seatAvailable(seatNum){
		
		var smemStatus = parseInt("${smvo.memStatus != null ? smvo.memStatus : 0}", 10);
		if(smemStatus == 1){
			alert("사용중인 좌석이 있습니다.");
			return;
		}
			
		var memID = "${mvo.memID}";
	   	if(!confirm(seatNum + "번 좌석을 발권하시겠습니까?")) {
	    	return; 
	    }

    $.ajax({
        url: "${cpath}/seat/seatAvailable",
        type: "post",
        data: { "seatNum": seatNum, "memID": memID },
        success: function() {
            //alert("seatAvailable 완료");
            // 버튼 상태 변경 가능
            selectSeat(seatNum);
            memStatus1();
        },
        error: function() {
            alert("좌석 발권 실패");
        }
    });
	}
	
	
	//memStatus → 1 변경  
	function memStatus1(){ 
		var memID = "${mvo.memID}";
	    $.ajax({
	        url: "${cpath}/seat/memStatus1",
	        type: "post",
	        data: { "memID": memID },
	        success: function() {        
	        	 //alert("memStatus1 상태변경성공");
	        },
	        error: function() {
	            alert("memStatus1 상태변경실패");
	        }
	    });
	}
	

	//좌석발권정보를 생성하기 위해 발권한 Seat정보 불러오기 
	function selectSeat(seatNum){
		
	    $.ajax({
	        url: "${cpath}/seat/selectSeat",
	        type: "post",
	        data: { "seatNum": seatNum },
	        success: function(seat) {
	            //alert(seat.seatName + "불러오기완료");
	            // 버튼 상태 변경 가능 
	            InsertR(seat);
	        },
	        error: function() {
	            alert("발권한 좌석정보 불러오기 실패");
	        }
	    });
		};
		
		
		//발권정보 생성하기 
		function InsertR(seat){

		var seatNum = seat.seatNum;
		var seatName = seat.seatName;
		var memID = "${mvo.memID}";
		var memName = "${mvo.memName}";	
		
	    $.ajax({
	        url: "${cpath}/seat/insertR",
	        type: "post",
	        data: { "seatNum": seatNum , "seatName": seatName , "memID": memID , "memName": memName },
	        success: function() {
	        	alert("발권되었습니다.");
	        		window.location.href = "${cpath}/seat/rInfo";
	        },
	        error: function() {
	            alert("발권정보생성 실패");
	        }
	    });
		};
		
		
		
	

	

	</script>
	
</body>
</html>





