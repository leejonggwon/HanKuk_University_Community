/*
작성자정보를 띄어줄모달
 */

$(document).on("click", ".writer", function(e) {	
				e.preventDefault();
				
			    var memID = $(this).data("writer"); 		   

			    $.ajax({
			        url: cpath + "/member/writerInfo",
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
			


