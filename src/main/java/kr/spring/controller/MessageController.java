package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.Message;

import kr.spring.entity.PageMaker;
import kr.spring.service.MessageService;

@Controller 
@RequestMapping("/message/*")
public class MessageController {
	
	@Autowired
	private MessageService service;
	
	//보낸메세지 메세지 체크삭제
	@PostMapping("/deleteRecordMsg2")
	public String deleteRecordMsg2(@RequestParam List<Integer> idxList, Criteria cri, RedirectAttributes rttr) {
		System.out.println(idxList);
		service.deleteRecordMsg2(idxList);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());	
		System.out.println("보낸메세지 체크박스 삭제기능 ");
		return "redirect:/message/msgRecordList";
		}
	
	
	//보낸메세지함 메세지삭제하기
	@PostMapping("/RecordDeleteMsg")
	public String RecordDeleteMsg(int msgIdx, Criteria cri, RedirectAttributes rttr) {
		service.recordDeleteMsg(msgIdx);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());	
		
		System.out.println("보낸메세지삭제");
		return "redirect:/message/msgRecordList";
	}
	
	

	//메세지 상세보기
	@RequestMapping("/msgRecordContent")                                          
	public String msgRecordContent(@RequestParam("msgIdx") int msgIdx, Model model, @ModelAttribute("cri") Criteria cri) {
		//@RequestParam 쿼리스트링이나 폼 데이터에서 하나의 값을 가져올 때 사용하는 어노테이션
		
		System.out.println("게시글 상세보기 기능수행");
		Message vo = service.msgContent(msgIdx); 
		model.addAttribute("vo", vo); 
	
	return "message/msgRecordContent";
	}
	

	
	//보낸메세지 조회기능
	@RequestMapping("/msgRecordList")
	public String msgRecordList(HttpSession session, Model model, Criteria cri) {
		
		Member mvo = (Member)session.getAttribute("mvo");
		String memID = mvo.getMemID();
		
		cri.setMemID(memID); //Criteria값도 함께 입력하기 위해서 
		
		List<Message> msgRecordList= service.msgRecordList(cri);
		
		//페이징 처리에 필요한 PageMaker 객체도 생성해야한다
		PageMaker pageMaker = new PageMaker();	
		
		//PageMaker가 페이징 기법을 하기위해 Criteria 정보가 필요하다 
		pageMaker.setCri(cri);       	
		
		int recordTotalCount= service.recordTotalCount(cri);
		
		int recordReadStatusTotalCount = service.recordReadStatusTotalCount(cri);
		
		//totalCount는 서비스를 통해 totalCount 메소드를 통해 구한다
		pageMaker.setTotalCount(recordTotalCount);

		model.addAttribute("msgRecordList", msgRecordList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("recordReadStatusTotalCount", recordReadStatusTotalCount);

		
		System.out.println("보낸메세지 조회 기능");
		
		return "message/msgRecordList";
	}

	
	//**@RequestParam() 을 붙여야 하는 이유는: 
	//1. 요청 데이터를 어떻게 매핑할지 스프링에게 알려주기 위해,
	//2. 특히 List 같은 복합 타입일 때 명확한 매핑이 필요하기 때문
	
	//메세지삭제2
	@PostMapping("/deleteMsg2")
	public String deleteMsg2(@RequestParam List<Integer> idxList, Criteria cri, RedirectAttributes rttr) {
		System.out.println(idxList);
		service.deleteMsg2(idxList);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());	
		
		return "redirect:/message/msgList";
	}
	

	//메세지삭제
	@PostMapping("/deleteMsg")
	public String deleteMsg(int msgIdx, Criteria cri, RedirectAttributes rttr) {
		
		service.deleteMsg(msgIdx);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());	
		
		return "redirect:/message/msgList";
	}
	
	//메세지보내기
	@PostMapping("/sendMsg")
	public String sendMsg(Message sendM, Criteria cri, RedirectAttributes rttr, HttpServletRequest request) {
		
		MultipartRequest multi = null;
	    int fileMaxSize = 100 * 1024 * 1024;
	    String savePath = "C:/cm_upload/message_upload/"; 	    
	    
	    File targetDir = new File(savePath);   
		if(!targetDir.exists()) {              
		    targetDir.mkdirs();                
		}  
		
		DefaultFileRenamePolicy def = new DefaultFileRenamePolicy();
		

		try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", def);
	    } catch (IOException e) {
	        e.printStackTrace();    
	        rttr.addFlashAttribute("msg", "파일 업로드 실패");
	        return "redirect:/message/sendMsgForm";
	    }
		
		 String toID = multi.getParameter("toID");
	     String fromID = multi.getParameter("fromID");
	     String fromName = multi.getParameter("fromName");
	     String fromMajor = multi.getParameter("fromMajor");
	     
	     String msgTitle = multi.getParameter("msgTitle");
	     String msgContent = multi.getParameter("msgContent");
		
	     String attached_data = multi.getFilesystemName("attached_data");
	     File attached_data_get = multi.getFile("attached_data");
		
	     sendM.setToID(toID);
	     sendM.setFromID(fromID);
	     sendM.setFromName(fromName);
	     sendM.setFromMajor(fromMajor);
	     sendM.setMsgTitle(msgTitle);
	     sendM.setMsgContent(msgContent);
		     
		 
	     
	     if(attached_data != null) {	    	 
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + attached_data; //예: a1b2c3d4_se1.png
		    
		    //파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (attached_data_get.renameTo(newFile)) {
		    	sendM.setAttached_data(newProfile); // UUID가 붙은 새 이름을 DB에 저장    
		    }
	    	 
	     }

		service.sendMsg(sendM);
		
		rttr.addFlashAttribute("result", sendM.getToID());
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());

		return "redirect:/message/msgList";
	}
	


	
	//메세지 쓰기 페이지를 이동
	@RequestMapping("/ListToSendMsgForm")
	public String ListToSendMsgForm(Model model, HttpSession session, @ModelAttribute("cri") Criteria cri) {
		
		Member mvo = (Member)session.getAttribute("mvo");
		model.addAttribute("mvo", mvo);

		return "message/sendMsgForm";
	}	
	
	
	//메세지 쓰기 페이지를 이동
	@RequestMapping("/sendMsgForm")
	public String sendMsgForm(@RequestParam("toID") String toID, Model model, HttpSession session, @ModelAttribute("cri") Criteria cri) {
		
		Member mvo = (Member)session.getAttribute("mvo");
		model.addAttribute("mvo", mvo);
		
		//답장하기에서 toID가 넘어오는 경우
		if(toID != null) {
			model.addAttribute("toID", toID);
		}
		
		return "message/sendMsgForm";
	}	
	
	
	//메세지 상세보기
	@RequestMapping("/msgContent")                                          
	public String msgContent(@RequestParam("msgIdx") int msgIdx, Model model, @ModelAttribute("cri") Criteria cri) {
		//@RequestParam 쿼리스트링이나 폼 데이터에서 하나의 값을 가져올 때 사용하는 어노테이션
		
		System.out.println("게시글 상세보기 기능수행");
		Message vo = service.msgContent(msgIdx); 
		model.addAttribute("vo", vo); 
		
		//readStatus 0 → 1 
		service.readStatus1(msgIdx);
		
		return "message/msgContent";
	}
	
	
	//메세지리스트 페이지로 이동
	@RequestMapping("/msgList")
	public String msgList(Model model, HttpSession session, Criteria cri) {
		
		//현재로그인정보 
		Member mvo = (Member)session.getAttribute("mvo"); 
		String memID = mvo.getMemID();
		
		//dto에 setMemID데이터를 입력
		cri.setMemID(memID);	

		List<Message> msgList = service.msgList(cri);
		
		//페이징 처리에 필요한 PageMaker 객체도 생성해야한다
		PageMaker pageMaker = new PageMaker();	
		
		//PageMaker가 페이징 기법을 하기위해 Criteria 정보가 필요하다 
		pageMaker.setCri(cri);       	
		
		int msgTotalCount= service.totalCount(cri);
		int readStatus0TotalCount = service.readStatus0TotalCount(cri);
		
		
		//totalCount는 서비스를 통해 totalCount 메소드를 통해 구한다
		pageMaker.setTotalCount(msgTotalCount); 
		
		model.addAttribute("msgList", msgList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("msgTotalCount", msgTotalCount);
		model.addAttribute("readStatus0TotalCount", readStatus0TotalCount);
		
		//arriveStatus 0 → 1
		service.arriveStatus1(memID);
		
		return "message/msgList";
	}
	
	
	//다운로드버튼
		// :.+ : 파일 이름 뒤에 붙는 마침표(.)와 확장자까지 잘리지 않게 다 가져와라는 명령
		//ResponseEntity : '이 응답이 성공했는지', '어떤 성격의 데이터인지'를 알려주는 부가 정보를 담는 그릇
		//<Resource> : 실제 내용물
		@GetMapping("/download/{fileName:.+}") 
		public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
		   
			try {
		        String uploadDir = "C:/cm_upload/message_upload/"; 
		        
		        //path: 파일이 어디있는지 알려주는 역할(주소와 같은 역할)
		         //C:\boot_upload\profile_upload\ + a1b2c3d4...abc_test.jpg
		        Path path = Paths.get(uploadDir + fileName); 
		        
		        //resource: 주소에 직접 찾아가서 파일을 내용을 접근할 준비가 되어 있는상태 
		         //URL [file:/C:/boot_upload/board_upload/1773413837895_communication1.jpg]
		        // path.toUri() : 컴퓨터가 이해하기 쉬운 URL형식으로 변환
		        // new UrlResource() : 변환주소를 가지고 실제 파일에 접근하는 리소스객체를 생성
		        Resource resource = new UrlResource(path.toUri());

		        if (!resource.exists()) {
		            return ResponseEntity.notFound().build(); //없으면 404에러
		        }

		        // 1. 밀리초가 붙은 파일명에서 실제 이름만 추출 (예: 1773410514179_test.jpg -> test.jpg)
		        String downloadName = fileName;
		        //fileName에 '_'가 포함되어 있으면
		        // '_' 다음 문자부터 끝까지 잘라서 downloadName에 저장
		        if (fileName.contains("_")) { 
		            downloadName = fileName.substring(fileName.indexOf("_") + 1); 
		        }

		        // 2. 한글 파일명 깨짐 방지 인코딩
		        //test.jpg
		        String encodedFileName = UriUtils.encode(downloadName, StandardCharsets.UTF_8);
		       
		        // 3. 다운로드 헤더 설정 (다운로드방식과, 최종 파일 이름을 지정)
		        //  1. attachment: 첨부형태로 다운로드방식
		        //  2. filename=\"" + encodedFileName + "\" : UUID 떼고 한글인코딩 파일이름 지정
		        //attachment; filename="test.jpg
		        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";
		        
		        //서버가 준비한 택배 상자(파일)를 브라우저에게 최종적으로 던져주는 동작
		        return ResponseEntity.ok() //파일찾기 성공했다는 상태확인 
		                .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition) //행동 지시 라벨 부착
		                .contentType(MediaType.APPLICATION_OCTET_STREAM) //내용물 종류 선언
		                .body(resource);

		    } catch (Exception e) {
		        e.printStackTrace();
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		    }
		}
	
	

	
}
