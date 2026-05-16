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
		<div class="panel-heading">자료검색 - 소장자료 및 구독자료를 검색하세요.</div>
		<div class="panel-body">
			<!-- 검색메뉴 -->
		<div style="text-align:center">
			<form class="form-inline" action="${cpath}/book/bookList" method="post"> 
				<div class="form-group">
					<select name="type" class="form-control">
						<option value="bkTitle" ${pageMaker.cri.type=='bkTitle' ? 'selected' : ''} >도서명</option> 						
						<option value="bkAuthor" ${pageMaker.cri.type=='bkAuthor' ? 'selected' : ''} >작가</option>
						<option value="bkCompany" ${pageMaker.cri.type=='bkCompany' ? 'selected' : ''} >출판사</option>
					</select>
				</div>	
				<div class="form-group">
					<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
				</div>
				<button type="submit" class="btn btn-custom btn-sm">도서검색</button>	
				<br>
				<br>
				<p style="text-align: center">※검색어 없이 도서 검색 버튼을 누르면 전체 도서가 출력됩니다</p>											
			</form>
		</div>
				<br>
				
			<table style="width: 100%; table-layout: fixed; border-collapse: collapse;" 
					   class= "table table-bordered table-hover">
					<thead> <!-- thead: 테이블헤더를 구분해주는 영역태그 -->
						<tr>
							<th style="width: 7%; text-align: center;">번호</th>
							<th style="width: 10%; text-align: center;">분류</th>
				            <th style="width: 20%; text-align: center;">제목</th>
				            <th style="width: 14%; text-align: center;">작가</th>
				            <th style="width: 12%; text-align: center;">출판사</th>
				            <th style="width: 16%; text-align: center;">ISBN</th>			            
				            <th style="width: 10%; text-align: center;">청구기호</th>
				            <th style="width: 9%; text-align: center;">보유도서수</th>
						</tr>
					</thead>
					<tbody> <!-- tbody: 테이블안에 영역구분하기 위한 태그 -->
						<c:forEach items="${list}" var="vo" varStatus="i"> <!-- model.addAttribute("list", list) -->
				            <tr>
				                <td style="text-align: center">${pageMaker.totalCount - ((pageMaker.cri.page - 1) * pageMaker.cri.perPageNum + i.index)}</td>	
				                <td style="text-align: center">${vo.bkCategory}</td>  				                    
				                <td style="text-align: center">
					                <c:choose>
						                <c:when test="${mvo.memRole == '관리자'}">
							               	<a class="move" href="${vo.bkNum}">
						                		${vo.bkTitle}
						                	</a>
							            </c:when>
							            <c:otherwise>
							            	${vo.bkTitle}
							            </c:otherwise>
					                </c:choose>	
				               </td>	
				                <td style="text-align: center">${vo.bkAuthor}</td>
				                <td style="text-align: center">${vo.bkCompany}</td>
				                <td style="text-align: center">${vo.bkIsbn}</td>
				                
				                <td style="text-align: center">${vo.bkCallNumber}</td>
				                <td style="text-align: center">${vo.bkCount}</td>
				            </tr>
				        </c:forEach>
					</tbody>
					<c:if test="${mvo.memRole == '관리자'}">
						<tr>
							<td colspan="8">
								<button id="regBtn" class="btn btn-sm btn-custom pull-right">도서등록</button>
							</td>
						</tr>		
					</c:if>	
				</table>
				
				
				
				
				<!-- 페이징 -->
				<div style="text-align: center">
					<ul class="pagination">
						
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1}">◀</a>
							</li>
						</c:if>
	
						<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<c:if test="${pageMaker.cri.page == pageNum}">
								<li class="paginate_button active"><a href="${pageNum}">${pageNum}</a></li>								
							</c:if>						
							<c:if test="${pageMaker.cri.page != pageNum}">
								<li class="paginate_button"><a href="${pageNum}">${pageNum}</a></li>								
							</c:if>													
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage +1}">▶</a>
							</li>
						</c:if>						
					</ul>
					<form action="${cpath}/book/bookList" id="pageFrm">
						<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
						<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
						
						<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
					  	<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
					  	<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
							
				</div>
		</div> 
		<div class="panel-footer">MVC Communication - All rights reserved</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var pageFrm = $("#pageFrm");
			
			$(".paginate_button a").on("click", function(e) {
				e.preventDefault();
				
				var page = $(this).attr("href");
				pageFrm.find("#page").val(page);
				pageFrm.submit();
			});
			
			$(".move").on("click", function(e){
				e.preventDefault(); //a태그의 링크이동 기능을 막는다 
				
				//게시글 클릭한 a태그의 href값(idx) 가져오기
				var bkNum = $(this).attr("href"); 
				
				//idx 정보를 넘길 hidden input 태그 생성
				var tag = "<input type='hidden' name='bkNum' value='" + bkNum + "'>";
				
				pageFrm.append(tag); 
						
				pageFrm.attr("action", "${cpath}/book/bookContent");
				pageFrm.submit();
			});
			
			$("#regBtn").click(function() {
				//location.href="${cpath}/book/bookRegister";
				
				pageFrm.attr("action", "${cpath}/book/bookRegister");
				pageFrm.attr("method", "get");
				pageFrm.submit();
			});		

		});

	</script>
	
</body>
</html>





