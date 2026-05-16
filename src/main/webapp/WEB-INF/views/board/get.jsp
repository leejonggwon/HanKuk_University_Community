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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">

<script src="${cpath}/resources/js/writer_modal.js"></script>
<style>

</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	  <div class="panel panel-default">
		<div class="panel-heading">Board Content</div>
		<div class="panel-body">
		<table class="table table-bordered table-hover">
		
		
	
			<tr>
				<td style="text-align: center;">분류</td>
				<td>
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
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">제목</td>
				<td><c:out value="${vo.title}"/></td>
			</tr>
			<tr>
				<td style="text-align: center; width: 12%;">내용</td>
				<td>
					<c:if test="${not empty vo.imgpath}">
						<br>
						<img src="${cpath}/board_upload/${vo.imgpath}" style="max-width:50%; height:auto;">		
						<br>	
						<br>
					</c:if>
	
					<textarea class="form-control" readonly="readonly" rows="8" cols=""><c:out value="${vo.content}"/></textarea>
				</td>
			</tr>
			
			<c:if test="${not empty vo.attached_data}">
				<tr>
					<td style="text-align: center">다운로드링크</td>
					<td><a id="attached_data" href="${cpath}/board/download/${vo.attached_data}">${vo.attached_data}</a></td>
				</tr>			
			</c:if>

			<tr>
				<td style="text-align: center;">작성자</td>
				<td class="writer" data-writer="${vo.memID}">
				   <a href="#"> ${vo.writer}</a>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">전공</td>
				<td>${vo.memMajor}</td>
			</tr>
			<tr>
				<td style="text-align: center;">조회수</td>
				<td>${vo.count}</td>
			</tr>
			<tr>
				<td style="text-align: center;">공감수</td>
				<td id="likeView"></td> 	
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">
					
					<!--좋아요버튼자리-->
					<button id="likeBtn" class="btn btn-default btn-sm" type="button" onclick="likePlus()">♡ 좋아요</button>			
					<button data-btn="reply" class="btn btn-sm btn-custom">답글쓰기</button>
					
					<c:if test="${mvo.memID eq vo.memID }">
						<button data-btn="modify" class="btn btn-sm btn-custom">수정화면</button>
						<button data-btn="remove" type="button" class="btn btn-sm btn-default">삭제</button>     
					</c:if>
						
					<button data-btn="list" class="btn btn-sm btn-default">목록</button>			

				</td>
			</tr>		
		</table>
		
		
		<form id="frm">
			<input id="idx" type="hidden" name="idx" value="${vo.idx}" >
			
			<input type="hidden" name="page" value="${cri.page}">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum}">	
				
			<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
		  	<input type="hidden" id="type" name="type" value="${cri.type}">
		  	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">		
		</form>
		</div> <!-- 게시판 panel-body 끝 -->
		
			
		<!-- 댓글작성폼 -->
		<div class="panel-body" id="cmtform"> 
			<form id="cmtfrm"> 
				<input type="hidden" name="idx" value="${vo.idx}">
				<input type="hidden" name="memID" value="${mvo.memID}">					
				<input type="hidden" name="memMajor" value="${mvo.memMajor}">					
				<input type="hidden" name="memProfile" value="${mvo.memProfile}">	
							
				<table id="cmtTbl" class="table table-bordered table-hover">
					<tr>
						<td style="text-align: center; vertical-align: middle;">댓글작성자</td>
						<td><input readonly="readonly" type="text" name="memName" value="${mvo.memName}" class="form-control"></td> 
						<td style="text-align:center; vertical-align:middle; width:80px;">
							<button class="btn btn-default btn-sm" type="reset" id="fclear">취소</button>
						</td>
					</tr>
					<tr>
						<td style="text-align: center; vertical-align: middle;">댓글내용</td>
						<td>
							<textarea placeholder="댓글을 입력해주세요." rows="2" cols="" " name="cmtContent" class="form-control"></textarea>
						</td> 
						<td style="text-align:center; vertical-align:middle; width:80px;"> 
							<button class="btn btn-custom btn-sm" type="button" onclick="cmtInsert()">댓글등록</button>											
						</td>
					</tr>		                        
				</table>
			</form>		
		</div> 
		
		<!-- 댓글리스트폼 -->
		<div class="panel-body">
		<div class="table-responsive" style="max-height: 500px;">
			<table id="cmtList" class="table table-bordered table-hover"> 	
				<tbody id="cmtView">
					<!--비동기 방식으로 가져온 댓글 나오게할 부분-->		
				</tbody>				
			</table>
		</div>		
		</div>
		
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %>
	  </div>
	</div>
	
	<!-- 작성자 정보를 띄어주는 모달 -->
	<%@ include file="/WEB-INF/views/common/writer_modal.jsp" %>

	
	<script type="text/javascript">
		//링크처리하기 
		$(document).ready(function() { //로딩되면 함수를 작동시키겠다 	
			
			//**$("button") → $("button[data-btn]"): <button>이면서 data-btn 속성을 가진 버튼만 선택		
			$("button[data-btn]").on("click", function(){ //버튼을 클릭하면 함수실행한다 
		
				var formData = $("#frm"); //form 태그 action값 주소를 바꿔주기위해 요소 가져오기 
				var btn = $(this).data("btn"); //현재 발생한 이벤트(클릭한 버튼요소)의 data-btn 속성값인
				                               // reply, modify, list 등 btn의 값을 가져온다  	 	
						                                                  
				if(btn == "reply"){ //답글버튼을 누르면
					formData.attr("action","${cpath}/board/reply"); //action 속성을 reply URL경로로 바꿔준다 
					formData.attr("method", "get");
				}else if(btn == "modify"){
					formData.attr("action","${cpath}/board/modify"); 
					formData.attr("method", "get");
				}else if(btn == "list"){
					formData.attr("action","${cpath}/board/list"); 
					formData.find("#idx").remove(); //list 페이지로 이동할 때는 보통 게시글 번호(idx)가 필요 없기 때문에
					                                //id="frm"요소안에 id="idx"를 찾아서 삭제한다
					formData.attr("method", "get");
				}else if("remove"){
					if(!confirm("게시글을 삭제하시겠습니까?")) {
				        return; //취소를 누르면 함수종료 된다
				    }	
					
					formData.attr("action", "${cpath}/board/remove");
					formData.attr("method", "post");
				}
				
				formData.submit(); //form태그의 id="frm"에 submit을 작동한다		
			});
			
			
			
			//게시글 작성자 클릭시 프로필 보이기 기능 
			//.writer 클래스를 가진 요소를 클릭하면 실행
			//document에 이벤트를 위임(delegate)한 방식
			$(document).on("click", ".writer", function(e) {	
				e.preventDefault();
				
			    var memID = $(this).data("writer"); 		   

			    $.ajax({
			        url: "${cpath}/member/writerInfo",
			        type: "get",
			        data: { "memID" : memID},
			        dataType: "json",
			        success: function(writerInfo) {	   
			        	$("#writerName").text("[이름] "+ writerInfo.memName);
			        	$("#writerMajor").text("[전공] "+ writerInfo.memMajor);
			        	
			        	$("#writerID").text("[학번] " + writerInfo.memID);	
			        	$("#writerID").data("writer_ID" , writerInfo.memID); 
			        	//id가 memID인 요소 내부에 "writer_ID"라는 사용자 정의 데이터 키로 실제 아이디 값을 숨겨서 저장한다
			        	//화면에는 보이지 않지만 JS에서 꺼내 쓸 수 있도록 데이터를 저장하는 코드
			        	
			            $("#writerUserCode").text("[회원코드]: "+ writerInfo.memUserCode);

			            $("#writerImg").attr("src",  writerInfo.memProfile             // writerInfo.memProfile에 
			            		? "${cpath}/profile_upload/" + writerInfo.memProfile // 값이 있으면 이 경로
			            		: "${cpath}/resources/images/default.png");			   // 값이 없으면 기본 이미지
			            $("#writerModal").modal("show");
			        },
			        error: function() {
			            alert("작성자 정보를 가져오는데 실패했습니다.");
			        }
			    });
			});
			
			
			//프로필에서 메시지보내기 폼으로 이동
			$("#regBtnProfile").on("click", function () {
			    window.location.href = "${cpath}/message/sendMsgForm?toID=" + $("#writerID").data("writer_ID");
			    //writer_ID는 JS .writer에서 온거다
			});
			
			loadCmt();    //비동기방식으로 댓글 리스트 가져오기 기능			
			likeCount();  //likeCount 불러오기 기능				
			selectLike(); //Like객체 likeAvailable 불러오기		
			attached_dataName(); //첨부파일 이름 보기좋게

		}); //end ready()
		
		
		
		
		//비동기방식으로 댓글리스트를 가져오는 기능
		function loadCmt() {
			//문자열 → 정수(10진수)로 변환하는 역할
			var idx =  parseInt("${vo.idx}", 10);
			
			$.ajax({
				url : "${cpath}/comment/loadCmt",    
				type: "get",      
				data : { "idx" : idx }, 
				dataType: "json",  //서버로부터 돌려받을 데이터 타입
				success: cmtView,  //콜백함수:다른 함수의 인자로 전달되어 특정 작업이 끝난 후 호출되는 함수
				error: function(){ alert("댓글로드실패"); }
			});
		}
		
		//댓글의 정보를 받아온다
		//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 
		function cmtView(data){
			
			var listHtml = "";
		
			//$.each: jQuary반목문
			//data: AJAX 요청에서 서버가 반환한 전체 데이터
			//index: 배열의 인덱스, obj: 배열의 해당 인덱스 값 data[index]
			$.each(data, function(index, obj){ //index:순서 표시자
				
				//1763895209000 → 2025-11-23 21:11 
				var date = new Date(obj.cmtIndate); //Data 객체로 변환
				//Date 객체에서 각 정보를 뽑아 보기 좋은 문자열로 변환
		        var formatted = date.getFullYear() + '-' +
		                        ('0' + (date.getMonth()+1)).slice(-2) + '-' +		                        
		                        // 11+1 → 12
		                        // '0' + 12 →'012' (문자열)
		                        // ('012').slice(-2)  → "12" :뒤에서 2자리만 가져오기 때문에 두 자리 확보
		                        // "12"+'-' → "12-"
		                        ('0' + date.getDate()).slice(-2) + ' ' +
		                        ('0' + date.getHours()).slice(-2) + ':' +
		                        ('0' + date.getMinutes()).slice(-2);
		                        
				listHtml += "<tr>";
				
				//프로필 이미지가 있으면 업로드 경로의 이미지를 사용하고, 없으면 기본 이미지를 사용
			    var imgSrc = obj.memProfile 
                ? "${cpath}/profile_upload/" + obj.memProfile 
                : "${cpath}/resources/images/default.png"; 
                
                listHtml += "<td style='text-align:center; vertical-align:middle; width:80px;'>"
                listHtml += "<img style='width:40px; height:40px;' class='img-circle' src='" + imgSrc + "' />";
                listHtml += "</td>";  
                
            
                
                listHtml += "<td class='writer' data-writer='" + obj.memID + "' style='text-align:center; vertical-align:middle; width:80px;'>";
    			listHtml += "<a href='#' class='writer-link'>" + obj.memName + "</a></td>";
				
				
				listHtml += "<td style='text-align:center; vertical-align:middle; width:110px;'>" + obj.memMajor + "</td>";
     
				//if문으로 삭제유무 표시
				if (obj.cmtAvailable == 0) {				
					listHtml += "<td><span class='form-control' style='color: #999;'>"; 
					listHtml += "작성자에 의해 삭제된 댓글입니다.</span></td>";					
				
				} else if (obj.cmtAvailable == 1) {
					listHtml += "<td><span class='form-control' style='height: auto; min-height: 40px; white-space: normal; word-break: break-all;'>"; 
					var cleanContent = obj.cmtContent.replace(/\n/g, "<br>");				
					listHtml += cleanContent + "</span></td>";
				}	

				listHtml += "<td style='text-align:center; vertical-align:middle; width:180px;'>" + formatted + "</td>"; //댓글날짜		
				
				//삭제된 게시물이면 삭제버튼 비활성화한다
				listHtml += "<td style='text-align:center; vertical-align:middle; width:80px;'>";					
				var memID = "${mvo.memID}"; //현재로그인된 memID
				if (obj.cmtAvailable == 0) {									
					listHtml += "<button disabled type='button' class='btn btn-default btn-sm'>삭제됨</button>";					
				} else if (obj.cmtAvailable == 1 &&  memID == obj.memID) {				
					listHtml += "<button type='button' class='btn btn-custom btn-sm'"; 		
					listHtml += "onclick='cmtDelete(" + obj.cmtIdx + ")'>삭제</button>";		
				} else if (obj.cmtAvailable == 1 &&  memID != obj.memID) {				
					listHtml += "<button disabled type='button' class='btn btn-custom btn-sm'"; 		
					listHtml += "onclick='cmtDelete(" + obj.cmtIdx + ")'>삭제</button>";		
				}
				listHtml += "</td>";	
				
				listHtml += "</tr>";
			});
			
			$("#cmtView").html(listHtml);	
		}
		

		//댓글 등록버튼
		function cmtInsert(){

			//form 안의 입력값들을 AJAX로 바로 보낼 수 있는 문자열로 변환해주는 함수		
			var fData = $("#cmtfrm").serialize();
			console.log("fData: ", fData);
			//idx=123&memID=son&cmtContent=%EB%8C%93%EA%B8%80+%EB%82%B4%EC%9A%A9
			
			$.ajax({
				url : "${cpath}/comment/cmtInsert",
				type : "post",
				data : fData, 
				success : function(){ 
					loadCmt(); ////비동기방식으로 댓글리스트 가져오기 기능
				}, 
				error : function(){ alert("댓글등록실패")}
			});
			$("#fclear").trigger("click");
			//등록 후 폼을 초기 상태로 돌리기 위해 클릭 이벤트를 강제로 실행
		};
		
		
		//댓글삭제기능
		function cmtDelete(cmtIdx){
			//확인/취소창 
			if(!confirm("댓글을 삭제하겠습니까?")) {
		        return; //취소를 누르면 함수종료 된다
		    }	
			
			$.ajax({
				url : "${cpath}/comment/cmtDelete", 
				type : "get",        
				data : { "cmtIdx" : cmtIdx }, 
				success : function(){ 
					loadCmt(); 		
				},      
				error : function(){ alert("댓글삭제기능 오류")}
			});
		};
		
		
		//likeCount 불러오기 기능
		function likeCount(){
			var idx =  parseInt("${vo.idx}", 10);		
			
			$.ajax({
				url : "${cpath}/like/likeCount",    
				type: "get",      
				data : {"idx" : idx},  
				dataType: 'json',
				success: function(data){				
					$("#likeView").text(data.likeCount);								
			        },  
				error: function(){ alert("likeCount 불러오기실패"); }
			});
		};
		
		
		//likeCount+1
		function likePlus(){
			var idx =  parseInt("${vo.idx}", 10);		
			
			$.ajax({
				url : "${cpath}/like/likePlus",    
				type: "post",      
				data : { "idx" : idx},  
				success: function(){	
					insertLike(); //Like객체생성하기
					likeCount();  //likeCount 불러오기
			        },  
				error: function(){ alert("likeCount+1 실패"); }
			});
		};
		
		
		//Like객체생생하기
		function insertLike(){
			var idx =  parseInt("${vo.idx}", 10);	
			var memID = "${mvo.memID}";
			
			$.ajax({
				url : "${cpath}/like/insertLike",    
				type: "post",      
				data : {"idx" : idx, "memID" : memID},  
				success: function(){			
					selectLike(); //Like객체 likeAvailable 불러오기
			        },  
				error: function(){ alert("Like객체생생실패"); }
			});
		};
		
		
		//Like객체 likeAvailable 불러오기
		function selectLike(){
			var idx =  parseInt("${vo.idx}", 10);	
			var memID = "${mvo.memID}";
			
			$.ajax({
				url : "${cpath}/like/selectLike",    
				type: "get",      
				data : {"idx" : idx, "memID" : memID},
				dataType: 'json',
				success: function(data){	
					likeView(data); //버튼을 좋아요취소 상태로변경
			        },  
				error: function(){ }
			});
		};
		
		//사용자가 좋아요를 누른 상태라면 버튼을 좋아요취소 상태로 변경
		function likeView(data){
			if (data == 1) {
			    $("#likeBtn").text("♡ 좋아요").attr("onclick", "unLike()")
			    .removeClass()
		        .addClass("btn btn-danger btn-sm"); 
			}
		};
		
		
		//likeCount-1 기능
		function unLike(){
			var idx =  parseInt("${vo.idx}", 10);		
			$.ajax({
				url : "${cpath}/like/unLike",    
				type: "post",      
				data : { "idx" : idx},  
				success: function(){				
					deleteLike(); //Like객체 삭제하기
					likeCount();  //likeCount불러오기
			        },  
				error: function(){ alert("likeCount-1 실패"); }
			});
		};
		
	
		
		//Like객체삭제하기
		function deleteLike(){
			var idx =  parseInt("${vo.idx}", 10);	
			var memID = "${mvo.memID}";	
			$.ajax({
				url : "${cpath}/like/deleteLike",    
				type: "post",      
				data : {"idx" : idx, "memID" : memID},
				success: function(){
					unlikeView();
			        },  
				error: function(){ alert("Like객체삭제하기"); }
			});
		};
			
		//unlike 후 버튼 텍스트, 스타일을 기본 '좋아요' 상태로 초기화하고
		// 클릭 시 likePlus()을 호출하도록 이벤트를 변경
		function unlikeView(){
			 $("#likeBtn").text("♡ 좋아요").attr("onclick", "likePlus()")
			 .removeClass()
		     .addClass("btn btn-default btn-sm");
		};
		
		//첨부파일이름 조정
		function attached_dataName(){	
			var attached_data = $("#attached_data").text();
		
			if (attached_data.includes("_")) { 
				new_attached_data = attached_data.substring(attached_data.indexOf("_") + 1);
  			}
			
			$("#attached_data").text(new_attached_data);
		}
	</script>
	
</body>
</html>















