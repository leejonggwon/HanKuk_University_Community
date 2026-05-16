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

<style type="text/css">

body{padding:0;
font-family: Arial, sans-serif;
background-color: #BACEE0; /*배경*/
position: relative;
}

table{border: 1px solid #B2C7DA; /*테이블선*/
border-collapse:collapse;
margin: 20px auto;
width: 80%;
}

/*채팅구역*/
.resive_msg{padding: 10px;
 width: 100%;
 height: 600px;
 overflow: auto;
 overflow-x: hidden;
 background: #BACEE0; /*채팅구역*/
 border: 1px solid #ccc;
 border-radius: 0px;
}
 
.listTitle{height: 50px;
 vertical-align: top;
 font-size: 14px;
 font-weight: bold;
 color: #5a5a5a;
 text-align: center;
 margin-bottom: 10px;
 }
 
.memList{vertical-align: top;
 list-style: none;
 padding: 0;
 margin: 0;
 }
 
 /*접속자목록*/
.memListBox{text-align: center;
vertical-align: top;
padding: 10px;
overflow: auto;
background: #F5F5F5;
border-radius: 0px;
box-shadow: 0 2px 4px rgba(0,0,0,0.1);

 }
 
/*채팅입력박스*/
.chat_div{display: flex;
align-items: center;
width: 100%;
height: 45px;
padding: 5px;
margin-top: 10px;
border: 1px solid #ccc;
border-radius: 0px;
background: #ffffff;
box-shadow: 0 2px 4px rgba(0,0,0,0.1);
} 

.chat_btn{margin-left: 10px;
height: 35px;
width: 100px;
background-color: #FEE500;
color: black;
border: none;
border-radius: 0px;
cursor: pointer;
transition: background-color 0.3s;	
} 

.chat_btn:hover{background-color: #fdd835;
}

/*채팅방나가기*/
.outchat_btn {
    width: 100%; 
    height: 40px;             
    padding: 12px 0;         
    border: none;
    border-radius: 0px;
    background-color: #ccc;
    color: black;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}


.chat{flex: 1;
height: 35px;
padding: 5px;
border: 1px solid #ccc;
border-radius: 0px;
background-color: #ffffff;  /* 배경 */
}

.chat:focus {outline: none;
/*border-color: #80d8ff; */
} 
 
hr + br + br + .container::before{
content: "";
display: block;
width: 300px;
height: 150px;
margin: 20px auto;
/*background-image: url('https://images.unsplash.com/photo-1503264116251-35a269479413');*/
background-size: contain;
background-repeat: no-repeat;
background-position: center;
}
.gap td {
    height: 25px;
    background: transparent;
}



</style>

</head>
<body>
<!--  
	현재 참여중인 자신의 정보 및 채팅 리스트<br>
	아이디 : ${sessionScope.mem_id}<br>
	그룹아이디 : ${sessionScope.gr_id}<br>
	채팅참여 리스트 : ${applicationScope.chatList} -->
	
	<br>
	<div class="container">
		<button class="outchat_btn" onclick="roomClose()">← &nbsp; 채팅방 나가기</button>
		<table>
			<tr>
				<td colspan="2" align="center">채팅그룹명: <b id="group">${gr_id}</b></td>
			</tr>
			<tr class="gap">
			    <td colspan="2"></td>
			</tr>
			
			<tr>
				<td width="300px" height="400px" align="center">
					<div class="resive_msg" style="border: 1px">
						<div id="nickName">접속자 아이디: <b>${mem_id}</b></div>
					</div>
				</td>
				<td width="130px" class="memListBox">
					<div class="listTitle">접속자 목록</div>
					<div class="memList"></div>
				</td>
			</tr>
		</table>
		<div class="chat_div">
			<input placeholder="메시지 입력" type="text" class="chat" onkeypress="if(event.keyCode==13)$('.chat_btn').click();">
			<input type="button" class="chat_btn" value="내용전송">
		</div>
	</div>
	<script type="text/javascript">
	//TODO 014

	var ws =null;
	var url =null;
	var nick =null;
	var pageClosed = true;

	$(document).ready(function(){
		
		console.log("그룹 채팅 로딩...");
		url = location.href;
		
		var protocol = location.protocol === 'https:' ? 'wss://' : 'ws://';
		var wsUrl = protocol + location.host + "/controller/wsChatGr.do";
		
		var nick = document.querySelector("#nickName>b").textContent;
		var group = document.getElementById("group").textContent;
		console.log("요청주소", wsUrl);
		console.log("아이디", nick);
		console.log("그룹", group);
		
		$(".chat").focus();
		
		//웹소캣 객체 생성
		ws = new WebSocket(wsUrl);
		console.log("생성된 웹소객 객체:", ws);
		
		
		//객체 연결 후 open callback
		ws.onopen=function(){
			console.log("웹소캣 객체 오픈");
			ws.send("#$nickName_" + nick); //화면에서 로그인된 사용자 정보를 탐색된 값
		}
		
		//서버로 부터 전달받은 (handleTextMessage)의 전달된 값 확인 및 화면 출력
		ws.onmessage = function(event){
			var msg = event.data;
			console.log(event,msg);
			if(msg.startsWith("<font style")){ //입장과 퇴실 메시지
				$(".resive_msg").append($("<div class='noticeTxt'>")).append(msg+"<br>");
				//TODO 016 참여 목록창 REST 처리, 입장/퇴장 시 목록을 갱신
				viewList(group); 
				
			}else if(msg.startsWith("[나]"))	{
				$(".resive_msg").append($("<div class='sendTxt'>")).append($("<span class='send_img'>").text(msg)).append("<br><br>");     
			}else{
				$(".resive_msg").append($("<div class='resiveTxt'>")).append($("<span class='resiver_msg'>").text(msg)).append("<br><br>"); 
			}
			
			$(".resive_msg").scrollTop($(".resive_msg")[0].scrollHeight);
		}
		
		ws.onclose=function(){
			alert("서버와 연결이 종료되었습니다 채팅방이 삭제 됩니다");
		}
		
		$(".chat_btn").bind("click", function(){
			if($(".chat").val() == ""){
				alert("내용을 입력하세요");
				return;
			}else{
				ws.send(nick + ":" + $(".chat").val());
				$(".chat").val("");
				$(".chat").focus();
			}		
		});
		
		$(window).on('beforeunload', function(event){
			event.preventDefault();
			event.returnValue="";
			
			roomClose(); //채팅방이 종료 참여자 목록 갱신
			ws.close();
			return '내용이 저장되지 않음';
		});
		
	});

	var roomClose = function(){
		alert("채팅방종료");
		$.ajax({
			url:"${cpath}/chat/socketOut",
			type:"post",
			async:true,
			success:function(){
				pageClosed = false;
				self.close();
			}
		});
	}

	//TODO 017 서버 호출
	function viewList(grid){
		$(".memList").children().remove();
		$.ajax({
			url:"${cpath}/chat/viewChatList",
			type:"post",
			data:"gr_id=" + grid,
			dataType: "json",
			success:function(result){
				console.log(result.list);
				for(let str in result.list){
					if(grid == result.list[str]){
						$(".memList").prepend("<p style='border-bottom:0.5px solid #4b4b4b;'>"+str+"</p>");
					}
				}
			}
			
		});
	}


	
	</script>
	
	
</body>
</html>





