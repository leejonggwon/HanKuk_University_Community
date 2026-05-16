package kr.spring.controller;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.PageMaker;
import kr.spring.service.BoardService;

@Controller //@Controller로 인식
@RequestMapping("/board/*") //URL 일치시키는 설정
public class BoardController {
	
	//실질적인 일은 Service가 한다
	@Autowired
	private BoardService service;
	//BoardService는 인터페이스이다 
	//BoardService 구현한 클래스는 BoardServiceImpl을 가져다 사용한다 
	//BoardServiceImpl인데 BoardServiceImpl타입으로 들어가는 이유는
	//→ *객체가 부모타입인 BoardService로 업케스팅 된다(다형성을 이유로)
	

	
	//답글등록기능
	//Board vo = 부모글 번호, 작성ID, 제목, 답글, 작성자 이름
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr, HttpServletRequest request) {  
		
		MultipartRequest multi = null;
	    int fileMaxSize = 100 * 1024 * 1024;   
	    //파일의 저장경로(request요청 객체가 필요하다) 
	    
		String savePath = "C:/cm_upload/board_upload/"; //
		
		
		File targetDir = new File(savePath);   
		if(!targetDir.exists()) {              
		    targetDir.mkdirs();                
		}                                      

	    DefaultFileRenamePolicy def = new DefaultFileRenamePolicy();
	    
	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", def);
	    } catch (IOException e) {
	        e.printStackTrace();       
	    }
	    
	    String pageStr = multi.getParameter("page");
	    String perPageNumStr = multi.getParameter("perPageNum");
	    String type = multi.getParameter("type");
	    String keyword = multi.getParameter("keyword");
	    if(pageStr != null) cri.setPage(Integer.parseInt(pageStr));
	    if(perPageNumStr != null) cri.setPerPageNum(Integer.parseInt(perPageNumStr));
	    if(type != null) cri.setType(type);
	    if(keyword != null) cri.setKeyword(keyword);
	    
	    String memID = multi.getParameter("memID");
	    String category = multi.getParameter("category");
	    String title = multi.getParameter("title");
	    String content = multi.getParameter("content");
	    String writer = multi.getParameter("writer");
	    String memMajor= multi.getParameter("memMajor");
	    String idx = multi.getParameter("idx");
	    
	    String imgpath = multi.getFilesystemName("imgpath"); //se1.png
	    String attached_data = multi.getFilesystemName("attached_data"); 
	    
	    vo.setMemID(memID);
	    vo.setCategory(category);
	   	vo.setTitle(title);
	    vo.setContent(content);
	    vo.setWriter(writer);
	    vo.setMemMajor(memMajor);
	    vo.setIdx(Integer.parseInt(idx)); //MultipartRequest를 통해 넘어온 데이터는 무조건 문자열 이므로 숫자로 변환해준다 
	    
	    File imgpath_get = multi.getFile("imgpath"); //C:\cm_upload\profile_upload\se1.png
	    File attached_data_get = multi.getFile("attached_data"); 
		
		
	    if (imgpath != null) {
		    // UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + imgpath; // 예: a1b2c3d4_se1.png
		    
		    // 4. 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (imgpath_get.renameTo(newFile)) {
			     vo.setImgpath(newProfile); // UUID가 붙은 새 이름을 DB에 저장    
		    }
		}
	        
	    if (attached_data != null) {
		    // UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + attached_data; // 예: a1b2c3d4_se1.png
		    
		    // 4. 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (attached_data_get.renameTo(newFile)) {
			     vo.setAttached_data(newProfile); // UUID가 붙은 새 이름을 DB에 저장    
		    }
		}
		
		service.reply(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "답글 등록에 성공했습니다.");
		
		return "redirect:/board/list";
	}
	
	
	
	
	
	//댓글기능 페이지 이동기능
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//idx는 답글을 달고 싶어하는 게시글 번호를 의미한다 
		// service.get(idx)은 답글을 달고싶은 게스글 정보를 가져온다  
		Board vo = service.get(idx);
		model.addAttribute("vo", vo); 
		return "board/reply";
	}
	
	//삭제기능
	@PostMapping("/remove")
	public String remove(@RequestParam("idx") int idx, Criteria cri, RedirectAttributes rttr) {
		service.remove(idx);
		
		//page 이름으로 매개변수로 받아온 cri.page 값을 넣어준다 
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "게시글이 삭제 되었습니다.");
		
		return "redirect:/board/list";
	}

	//게시글 수정화면 
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//수정화면에는 새로 DB를 조회하므로 service.get(idx)을 그대로 사용한다
		Board vo = service.get(idx);  
		model.addAttribute("vo", vo); 
		return "board/modify";
	}
	
	
	//게시글 수정기능
	//같은 이름의 메소드: 오버로딩
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr, HttpServletRequest request) {
		
		MultipartRequest multi = null;
	    //int fileMaxSize = 5000 * 1024 * 10; //50MB  
		int fileMaxSize = 100 * 1024 * 1024; // 100MB
		
		String savePath = "C:/cm_upload/board_upload/"; 
		
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
	        return "redirect:/board/modify";
	    }
	    
	    String pageStr = multi.getParameter("page");
	    String perPageNumStr = multi.getParameter("perPageNum");
	    String type = multi.getParameter("type");
	    String keyword = multi.getParameter("keyword");
	    if(pageStr != null) cri.setPage(Integer.parseInt(pageStr));
	    if(perPageNumStr != null) cri.setPerPageNum(Integer.parseInt(perPageNumStr));
	    if(type != null) cri.setType(type);
	    if(keyword != null) cri.setKeyword(keyword);
	    
	    
	    String idx = multi.getParameter("idx");
	    String category = multi.getParameter("category");
	    String title = multi.getParameter("title");
	    String content = multi.getParameter("content");
	    
	    
	    String imgpath = multi.getFilesystemName("imgpath"); //se1.png
	    String originImgpath = multi.getParameter("originImgpath"); // 기존 파일 이름 (hidden)
	    
	    String attached_data = multi.getFilesystemName("attached_data"); 
	    String originAttached_data = multi.getParameter("originAttached_data"); 
	    
	    System.out.println("attached_data수 : "+ attached_data);
	    System.out.println("originAttached_data수: "+ originAttached_data);
	    
	    vo.setIdx(Integer.parseInt(idx));	    	 
	    vo.setTitle(title);
	    vo.setContent(content);
	    vo.setCategory(category);
	    
	    File imgpath_get = multi.getFile("imgpath"); //C:\cm_upload\profile_upload\se1.png
	    File attached_data_get = multi.getFile("attached_data"); 

	    
	    if (imgpath != null) {	    
		    // UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + imgpath; // 예: a1b2c3d4_se1.png
		    
		    // 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (imgpath_get.renameTo(newFile)) {
			     vo.setImgpath(newProfile); // UUID가 붙은 새 이름을 DB에 저장	        		         
		    }
		}else {
			vo.setImgpath(originImgpath);
		}

	    
	    if (attached_data != null) {  
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + attached_data; // 예: a1b2c3d4_se1.png
		    
		    // 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (attached_data_get.renameTo(newFile)) {
			     vo.setAttached_data(newProfile); // UUID가 붙은 새 이름을 DB에 저장	                 
		    }
		}else {
			vo.setAttached_data(originAttached_data);
		}
	    
	    service.modify(vo);
	  
	    //rttr.addFlashAttribute("modify_result", vo.getIdx());
	    
	    rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "게시글이 수정 되었습니다.");
	    
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());	
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
	  
		
	    return "redirect:/board/list"; //DB변경이 있으면 redirect 사용
	}

	    


	//게시글 상세보기
	@GetMapping("/get")                                          // model.addAttribute(cri)와 같은역할 
	public String get(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//@RequestParam 쿼리스트링이나 폼 데이터에서 하나의 값을 가져올 때 사용하는 어노테이션
		
		System.out.println("게시글 상세보기 기능수행");
		Board vo = service.get(idx); //idx와 일치하는 상세게시글
		//받아온 Board 객체를 get.jsp에 사용하기 위해 Model에 담는다
		service.boardCount(idx);
		System.out.println("게시글 조회수 기능수행");
		
		model.addAttribute("vo", vo); 
		return "board/get";
	}

	
	
	//게시물등록
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr, HttpServletRequest request) { 

	    MultipartRequest multi = null;
	    int fileMaxSize = 100 * 1024 * 1024;   
	    
		String savePath = "C:/cm_upload/board_upload/"; //
		
		
		File targetDir = new File(savePath);   
		if(!targetDir.exists()) {              
		    targetDir.mkdirs();                
		}                                      

	    DefaultFileRenamePolicy def = new DefaultFileRenamePolicy();
	    
	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", def);
	    } catch (IOException e) {
	        e.printStackTrace();       
	    }
	    
		    String memID = multi.getParameter("memID");
		    String title = multi.getParameter("title");
		    String content = multi.getParameter("content");
		    String writer = multi.getParameter("writer");
		    String memMajor = multi.getParameter("memMajor");
		    String category = multi.getParameter("category");
		    
		    String imgpath = multi.getFilesystemName("imgpath"); //se1.png
		    String attached_data = multi.getFilesystemName("attached_data"); 
		    
		    vo.setMemID(memID);
		   	vo.setTitle(title);
		    vo.setContent(content);
		    vo.setWriter(writer);
		    vo.setMemMajor(memMajor);
		    vo.setCategory(category);
		    
		    File imgpath_get = multi.getFile("imgpath"); //C:\cm_upload\profile_upload\se1.png
		    File attached_data_get = multi.getFile("attached_data"); 
	        
	    if (imgpath != null) {
		    // UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + imgpath; // 예: a1b2c3d4_se1.png
		    
		    // 4. 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (imgpath_get.renameTo(newFile)) {
			     vo.setImgpath(newProfile); // UUID가 붙은 새 이름을 DB에 저장    
		    }
		}
	        
	    if (attached_data != null) {
		    // UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + attached_data; // 예: a1b2c3d4_se1.png
		    
		    // 4. 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (attached_data_get.renameTo(newFile)) {
			     vo.setAttached_data(newProfile); // UUID가 붙은 새 이름을 DB에 저장    
		    }
		}
	    service.register(vo);
	    
	    rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");

	    return "redirect:/board/list"; 
	}


	
	//글쓰기 페이지를 이동
	@GetMapping("/register")
	public String register(@ModelAttribute("cri") Criteria cri) {
		
		return "board/register";
	}
	

	
	@RequestMapping("/list")
	public String boardList(Model model, Criteria cri) {
		//이제는 페이지 정보를 알고 있는 Criteria 객체를 Service에게 전달해준다
		List<Board> list = service.getList(cri); 
		
		//페이징 처리에 필요한 PageMaker 객체도 생성해야한다
		PageMaker pageMaker = new PageMaker();	
		
		//PageMaker가 페이징 기법을 하기위해 Criteria 정보가 필요하다 
		pageMaker.setCri(cri);       	
		//totalCount는 서비스를 통해 totalCount 메소드를 통해 구한다
		pageMaker.setTotalCount(service.totalCount(cri)); 
		
		model.addAttribute("list", list);
		
		//페이징 정보를 알고있는 객체를 전달한다 
		//pageMaker에는 Criteria 정보, 총 게시글 수 정보를 가지고 있다
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	
	
	//다운로드버튼
	// :.+ : 파일 이름 뒤에 붙는 마침표(.)와 확장자까지 잘리지 않게 다 가져와라는 명령
	//ResponseEntity : '이 응답이 성공했는지', '어떤 성격의 데이터인지'를 알려주는 부가 정보를 담는 그릇
	//<Resource> : 실제 내용물
	@GetMapping("/download/{fileName:.+}") 
	public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
	   
		try {
	        String uploadDir = "C:/cm_upload/board_upload/"; 
	        
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















