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
		<div class="panel-heading"><span class="glyphicon glyphicon-send"></span>
			<span style="padding-left:5px;">보낸 메세지함 ${recordTotalCount}</span> 	
		</div>
		<div class="panel-body">
		
		<button id="deleteBtn" class="btn btn-default btn-sm pull-left" style="margin: 0px 0px 15px 5px;">삭제</button>	
		<button id="msgListBtn" class="btn btn-custom btn-sm pull-left" style="margin: 0px 0px 15px 5px;">
			<span class="glyphicon glyphicon-folder-open"></span>&nbsp; 받은 메세지함 이동
		</button>	
		
		<!-- **검색메뉴 -->	
			<div style="text-align:right; margin: 0px 320px 10px 0px;">
				<form class="form-inline" action="${cpath}/message/msgRecordList" method="get"> 
					<div class="form-group">
						<select name="type" class="form-control">
							<option value="toID" ${pageMaker.cri.type=='toID' ? 'selected' : ''} >수신자 아이디</option>							
							<option value="msgTitle" ${pageMaker.cri.type=='msgTitle' ? 'selected' : ''} >메세지 제목</option> 				
						</select>
					</div>	
					<div class="form-group">
						<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
					</div>
					<button type="submit" class="btn btn-light btn-custom">검색</button>									
				</form>
			</div>
		
		
		<table style="width: 100%; table-layout: fixed; border-collapse: collapse;" class= "table table-bordered table-hover">
			<thead> 			
				<tr>
					<th style="width: 7%; text-align: center;">체크</th>
					<th style="width: 9%; text-align: center;">열람상태</th>
		            <th style="width: 12%; text-align: center;">수신자 아이디</th>
		            <th style="width: 57%; text-align: center;">메시지 제목</th>
		            <th style="width: 15%; text-align: center;">발송일자</th>
				</tr>
			</thead>
			
			<tbody> <!-- tbody: 테이블안에 영역구분하기 위한 태그 -->
				<c:forEach items="${msgRecordList}" var="vo" varStatus="i"> 
			        <c:if test="${vo.delFromID == 0}">	    
			            <tr>
			            	<td style="text-align: center">				            	
							      <input class="msgCheck" type="checkbox" value="${vo.msgIdx}">							    
			            	</td>
	       	
			            	<c:if test="${vo.readStatus == 0}">
			            		<td style="text-align: center">미열람</td>
			            	</c:if>
			            	<c:if test="${vo.readStatus == 1}">
			            		<td style="text-align:center; color: #999999;">열람</td>
			            	</c:if>
	
							<td style="text-align:center" class="writer" data-writer="${vo.toID}">
								<a href="#"> ${vo.toID} </a>
							</td>
							
			                <td>
			                	<a class="move" href="${vo.msgIdx}">                                                                                          					                	
				                		${vo.msgTitle}		              
				                </a>
					        </td>                	                                                                                      					                	
	      
			                <td style="text-align: center">
			                	<fmt:formatDate value="${vo.msgDate}" pattern="yyyy.MM.dd hh:mm"/>			             
			                </td>			             
			            </tr>
		            </c:if>	
		        </c:forEach>
			</tbody>	
		</table>
		
		<!-- **페이징버튼 -->	
			<div style="text-align: center">			
			  <ul class="pagination">
			  	
			  	<!-- 이전버튼처리 -->
			  	<c:if test="${pageMaker.prev}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.startPage - 1}">◀</a>
			  		</li>
			  	</c:if>
			  	
			  	<!-- 이전버튼처리(페이지용) -->
			  	<c:if test="${pageMaker.prevPage}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.cri.page - 1}">◁</a>
			  		</li>
			  	</c:if>
			  
			    <!-- 페이지번호 처리하기 -->
			    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
			    	<c:if test="${pageMaker.cri.page == pageNum}">
			    		<li class="paginate_button active"><a href="${pageNum}">${pageNum}</a></li>	
			    	</c:if>
			    				
			    	<c:if test="${pageMaker.cri.page != pageNum}">
			    		<li class="paginate_button"><a href="${pageNum}">${pageNum}</a></li>	
			    	</c:if>				 
			    </c:forEach>					   		    
			    
			   <!-- 다음버튼(페이지용) -->
			  	<c:if test="${pageMaker.nextPage}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.cri.page + 1}">▷</a>
			  		</li>
			  	</c:if>				  			 
			  			  				  		    
			    <!-- 다음버튼처리 -->
			  	<c:if test="${pageMaker.next}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.endPage + 1}">▶</a>
			  		</li>
			  	</c:if>				  				  		    
		</div>
				
		  <!-- 페이지 버튼을 클릭했을 때 페이지 이동을 처리하기 위한 숨겨진(form) 전송용 폼 -->
		  <form action="${cpath}/message/msgRecordList" id="pageFrm">
		  	<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
		  	<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">	
		  	
		  	<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
		  	<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
		  	<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">			  			  	
		  </form>
		  
		</div>
		<%@ include file="/WEB-INF/views/common/bottom.jsp" %> 
	  </div>
	</div>
		
	<!-- 작성자 정보를 띄워줄 모달 -->
	<div class="modal fade" id="writerModal" role="dialog">
	  <div class="modal-dialog">  
	    <div class="modal-content panel-primary" id="writerType">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">작성자 정보</h4>
	      </div>
	      
	      <div class="modal-body text-center">
	        <img id="writerImg" src="" style="width:120px; height:120px; border-radius:50%; margin-bottom:10px;">     
	       
	        <p id="writerID" style="font-size:16px;"></p>           
	        <p id="writerName" style="font-size:16px;"></p>
	        <p id="writerMajor" style="font-size:16px;"></p>
	        <p id="writerUserCode" style="font-size:16px;"></p>
	        
	        <button id="regBtnProfile" class="btn btn-custom btn-sm">메세지 보내기</button>
	      </div>
	      
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<script type="text/javascript">
	$(document).ready(function () {
		
		//**페이지 번호 클릭 시 이동하기 
		//form태그의 id=pageFrm 인 요소를 선택
		var pageFrm = $("#pageFrm");
		
		//<li class="paginate_button"의 a태그를 클릭하면 함수를 실행한다 
		$(".paginate_button a").on("click", function(e){ 			
			//e : 현재 클릭한 a태그 요소 차체를 의미한다			
			// board/5 → board/list?page=5&perPageNum=10
		 	e.preventDefault(); //a태그의 링크이동 기능을 막는다 
		 	
			var page = $(this).attr("href"); //클릭한 a 태그의 href 값을 읽어서 page 변수에 담는다
			
			//id=pageFrm인 form태그 안에서 
			// id=page 요소를 찾아서 value 변수에 page값(현재 클릭한 a태그의 href값)을 입력한다
			pageFrm.find("#page").val(page); 
			pageFrm.submit(); //form태그 제출된다 
		});
		
		
		//클릭하면 보낸메세지 페이지 이동
		$("#msgListBtn").click(function(){
			location.href="${cpath}/message/msgList"; 
		});
		
		
		//**상세보기 클릭 시 이동
		$(".move").on("click", function(e){
			
			e.preventDefault(); //a태그의 링크이동 기능을 막는다 
			
			//게시글 클릭한 a태그의 href값(msgIdx) 가져오기
			var msgIdx = $(this).attr("href"); 
			
			//idx 정보를 넘길 hidden input 태그 생성
			var tag = "<input type='hidden' name='msgIdx' value='" + msgIdx + "'>";
			
			pageFrm.append(tag); //id=pageFrm인 form태그에 hidden input 태그 추가한다
			
			//form이 데이터를 전송할 URL을 바꾼다
			pageFrm.attr("action", "${cpath}/message/msgRecordContent");	
			pageFrm.submit();
		});//상세보기
		
		//체크박스 선택 후 삭제버튼 클릭시 
		$("#deleteBtn").click(function(e) {
			e.preventDefault(); //브라우저가 버튼 누르자마자 form 제출하려고 해서 그거 막는기능
			
			if(!confirm("메일을 삭제하시겠습니까?")) {
		        return; //취소를 누르면 함수종료 된다
		    }	
			
		    const checkedValues = []; //체크박스 선택한 값들 
		    
			//체크된 msgCheck 요소들을 → checkedValues에 값이 입력한다
		    $(".msgCheck:checked").each(function () {
		        checkedValues.push($(this).val());
		    });

			//checkedValues에 선택한 데이터가 없을경우
		    if (checkedValues.length === 0) {
		        alert("삭제할 항목을 선택하세요.");
		        return;
		    }

			//forEach를 통헤사 checkedValues안에 있는 각각요소를 꺼내서 실행하는 기능
		    checkedValues.forEach(function(msgIdx){
		        let tag = "<input type='hidden' name='idxList' value='" + msgIdx + "'>";
		        pageFrm.append(tag); //요소들 추가
		    });
		    
		    //pageFrm 전송폼
		    pageFrm.attr("action", "${cpath}/message/deleteRecordMsg2"); //주소
			pageFrm.attr("method", "post"); //전송방식
			pageFrm.submit();
		}); //삭제체크박스버튼
		
		//게시글 작성자 클릭시 프로필 보이기 기능 
		$(".writer").on("click", function() {
			
		    var memID = $(this).data("writer"); 		   

		    $.ajax({
		        url: "${cpath}/member/writerInfo",
		        type: "get",
		        data: { "memID" : memID},
		        dataType: "json",
		        success: function(writerInfo) {	   
		        	$("#writerName").text("[이름]: "+ writerInfo.memName);
		        	$("#writerMajor").text("[전공]: "+ writerInfo.memMajor);
		        	
		        	$("#writerID").text("[학번]: " + writerInfo.memID);	
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
		
	});
	
	
	</script>
	
</body>
</html>





