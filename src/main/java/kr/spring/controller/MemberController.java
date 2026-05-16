package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Member;

import kr.spring.service.MemberService;

@Controller
@RequestMapping("/member/*") //login으로 해서 들어오는것들은 LoginController에서 받아드린다 
public class MemberController {
	
	//MemberService를 따로 만들어야하지만 로그인,로그아웃 기능만 사용하므로 BoardService 가져다 사용한다 
	@Autowired
	private MemberService service;

	//로그아웃
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session) {
		session.invalidate(); //세션만료(3tier가지 않는다)
		return "redirect:/";
	}
		
	
	//로그인
	@PostMapping("/loginProcess")
	public String login(Member vo, RedirectAttributes rttr, HttpSession session) { //id와 password Member vo에 담김
		
		Member userInfo = service.login(vo); //일치하면 Member 형태로 로그인한 회원의 모든 정보들어있다
		
		if(userInfo != null) {
			 System.out.println("로그인 성공");
			 	session.setAttribute("mvo", userInfo); //header.jsp에서 "mvo"로 판단하므로 "mvo"로 이름을 준다
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 성공했습니다");
				return "redirect:/board/list";
		 }else{
			 System.out.println("로그인 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 실패했습니다");
				return "redirect:/";
		 }
	}
	
	@RequestMapping("/joinForm")
	public String joinForm() {
		System.out.println("회원가입 페이지로 이동");
		return "member/joinForm"; //뷰네임을 돌려준다
	}
	
	
	
	@RequestMapping("/join")
	public String join(Member m, RedirectAttributes rttr, HttpSession session) { // 넘어오는 name 값과 Member 필드명이 같으면, 하나로 묶은 Member로 받을 수 있다
		                                                                         // HttpSession 사용자별 데이터를 서버에 잠깐 저장하고 관리하는 공간
		System.out.println("회원가입 기능요청");
		
		// 유효성검사: 백엔드 개발자는 필수적으로 유효성 검사를 해야 한다
		// → 값이 null 이거나 빈 문자열("")인 경우, 또는 숫자가 0인 경우를 체크한다
		if(m.getMemID() == null || m.getMemID().equals("") || //m.getMemID() == null는 jsp name값이 틀렸다는 의미
		   m.getMemPassword() == null || m.getMemPassword().equals("") ||
		   m.getMemName() == null || m.getMemName().equals("") ||	      
		   m.getMemAge() == 0 ||
		   m.getMemEmail() == null || m.getMemEmail().equals("") 
		   ) {
			//회원가입을 할 수 없는 부분, 하나라도 누락되어 있기 때문에 
			
			//실패시 joinForm.do로 msgType과 msg 내용을 보내함
			//msgType: "실패메세지", msg: "모든 내용을 입력하세요" 보낼것임 
			
			//리다이렉트 방식은 model을 사용할 수 없다(포워딩방식만 가능하다) → 그러므로 RedirectAAttributtes 사용한다
			// RedirectAAttributtes - 리다이렉트 방식으로 이동할때 보낼 데이를 저장하는 객체
			// RedirectAAttributtes 저장데이터는 해당 jsp에 page context에 저장된다
			// addFlashAttribute는 리다이렉트할 때 1회성으로 데이터를 전달하는 메서드
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/joinForm"; //다시 회원가입 입력하는 폼으로 다시 요청하도록 시킨다 	
			
		}else {
			//누락된것이 없으므로 회원가입을 시도할 수 있는 부분	
			m.setMemProfile(""); //null을 넣고 싶지 않을 때 빈 문자열로 초기화
			int cnt = service.join(m); //cnt가 1이면 회원가입성공, 0이면 실패  
			
			if(cnt == 1) {
				System.out.println("회원가입 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다");
				//회원가입 성공 시 로그인 처리까지 시키기
				//로그인 정보 저장 (m에 Member 정보가 저장되어 있다)
				session.setAttribute("mvo", m); 
				//세션 유지 → session.setMaxInactiveInterval(60*60); // 1시간(초 단위)
				//로그아웃 처리 → session.invalidate(); 
				return "redirect:/";
			}else {
				System.out.println("회원가입 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다");
				return "redirect:/joinForm";
			}
		}
	}
	

	
	//회원사진등록 페이지 이동
	@GetMapping("/imageForm")
	public String imageForm() {
		System.out.println("회원사진등록 페이지 이동");
		return "member/imageForm"; 
	}
	

	//회원사진등록 기능
	@RequestMapping("/imageUpdate")
	public String imageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
		
		// 파일업로드를 할 수 있게 도와주는 객체 (cos.jar)
		// 파일업로드를 할 수 있게 도와주는 MultipartRequest 객체를 생성하기 위해서는
		// 5개의 정보가 필요하다
		// 요청데이터, 저장경로, 최대크기, 인코딩, 파일명 중복제거
		MultipartRequest multi = null;
		
		//파일의 저장경로(request요청 객체가 필요하다) 
		String savePath = "C:/cm_upload/profile_upload/"; //
		System.out.println("savePath: " + savePath);
		
		File targetDir = new File(savePath);   //
		if(!targetDir.exists()) {              //
		    targetDir.mkdirs();                //
		}                                      //
		
		
		System.out.println("실제이미지주소: " + savePath);
		
		int fileMaxSize = 10 * 1024 * 1024; // 10mb까지 가능한 파일의 최대크기 
		
		System.out.println(savePath); //이미지가 저장된 경로 
		
		// 기존 해당 프로필 이미지 삭제
		// - 로그인 한 사람의 프로필 값을 가져와야함
		String memID = ((Member)session.getAttribute("mvo")).getMemID();
		
		// getMember 메소드는 memID와 일치하는 회원의 정보 (Member)를 가져온다
		String oldImg = service.fromIDInfo(memID).getMemProfile();
		
		File oldFile = new File(savePath + "/" + oldImg);
		if(oldFile.exists()) {
			oldFile.delete();
		}
		
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 내가 업로드한 파일 가져오기
		File file = multi.getFile("memProfile");
		
		if(file != null) { // 업로드가 된 상태
			// System.out.println(file.getName());
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			
			if(!(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG"))) {
				
				if(file.exists()) {
					file.delete();
					rttr.addFlashAttribute("msgType", "실패메세지");
					rttr.addFlashAttribute("msg", "이미지 파일만 가능합니다.(PNG, JPG, GIF)");
					return "redirect:/member/updateForm";
				}
			}
		}
		
		
		String fileName = multi.getFilesystemName("memProfile");
		
		System.out.println("fileName: " + fileName);  //se1.png
		System.out.println("file: " + file);          //C:\cm_upload\profile_upload\se1.png
		
		if (fileName != null) {
	    
		    // 2. 확장자 추출
		    String ext = fileName.substring(fileName.lastIndexOf(".")); // .jpg 등
		    
		    // 3. UUID 생성 후 새 파일명 만들기
		    String uuid = UUID.randomUUID().toString();
		    String newProfile = uuid + "_" + fileName; // 예: a1b2c3d4...jpg
		    
		    // 4. 파일명 변경 (Rename)
		    File newFile = new File(savePath + newProfile);
		    if (file.renameTo(newFile)) {
		        // 변경 성공 시 DB에 저장할 객체에 세팅
		        Member mvo = new Member();
		        mvo.setMemID(memID);
		        mvo.setMemProfile(newProfile); // UUID가 붙은 새 이름을 DB에 저장
		        
		        service.profileUpdate(mvo);
		    
		    }
		}
		
		// 사진 업데이트 후 수정된 회원정보를 다시 가져와서 세션에 담기
		Member m = service.fromIDInfo(memID); // 이전의 getMember와 같다
		session.setAttribute("mvo", m);
		
		rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다.");
		return "redirect:/board/list";
	}
	
	

	//업데이트폼 이동 
	@RequestMapping("/updateForm")
	public String updateForm() {
		System.out.println("회원정보수정 페이지로 이동");
		return "member/updateForm"; 
	}
	

	//업데이트기능
	@RequestMapping("/update")
	public String update(Member m, RedirectAttributes rttr, HttpSession session) {
	    // 1. 세션 체크 (NPE 방지)
	    Member mvo = (Member)session.getAttribute("mvo");
	    if(mvo == null) {
	        return "redirect:/member/loginForm";
	    }

	    // 2. 유효성 검사
	    if(m.getMemEmail() == null || m.getMemEmail().trim().equals("")) {
	        rttr.addFlashAttribute("msgType", "실패메세지");
	        rttr.addFlashAttribute("msg", "이메일을 입력해주세요.");
	        return "redirect:/member/updateForm";
	    }

	    // 3. 기존 데이터 보존
	    m.setMemProfile(mvo.getMemProfile());
	    // 만약 JSP에서 memID를 hidden으로 안 보냈다면 여기서 강제로 세팅해줘야 함
	    if(m.getMemID() == null) m.setMemID(mvo.getMemID());

	    int cnt = service.update(m);

	    if(cnt == 1) {
	        // 4. 세션 업데이트 (중요: m을 통째로 넣지 말고 mvo를 수정해서 넣기)
	        mvo.setMemEmail(m.getMemEmail()); 
	        session.setAttribute("mvo", mvo); 
	        
	        rttr.addFlashAttribute("msgType", "성공메세지");
	        rttr.addFlashAttribute("msg", "이메일 수정에 성공했습니다");
	        return "redirect:/board/list";
	    } else {
	        rttr.addFlashAttribute("msgType", "실패메세지");
	        return "redirect:/member/updateForm";
	    }
	}
	
	//업데이트기능
	@RequestMapping("/passwordUpdate")
	public String passwordUpdate(Member m, RedirectAttributes rttr, HttpSession session) {
		//유효성검사 
		if(m.getMemPassword() == null || m.getMemPassword().equals("")
		  ) {
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/member/updateForm"; //다시 회원가입 입력하는 폼으로 다시 요청하도록 시킨다
			
		}else{
			//회원정보 수정할때 이미지가 날아가는것 방지하는 첫번째 방법
			Member mvo = (Member)session.getAttribute("mvo"); 
			m.setMemProfile(mvo.getMemProfile()); //로그인한 Member의 MemProfile 값울 담는다
			
			int cnt = service.passwordUpdate(m); 
			
			if(cnt == 1) {
				System.out.println("회원정보수정 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "비밀번호 변경에 성공했습니다");
				session.setAttribute("mvo", m); //회원정보 session도 업데이트해야한다
				return "redirect:/";		
			}else {
				System.out.println("회원정보수정 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "비밀번호 변경에 실패했습니다");
				return "redirect:/member/updateForm";
			}
		}
	}

	
	

	//프로필이미지삭제
	@PostMapping("/imageDelete")  
	public String imageDelete(String memID, RedirectAttributes rttr, HttpSession session) { 

		int cnt = service.imageDelete(memID);
		
		if(cnt == 1) {			
			rttr.addFlashAttribute("msgType", "성공메세지"); 
			rttr.addFlashAttribute("msg", "프로필이미지가 삭제되었습니다");			
		}else {
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "프로필이미지 삭제에 실패했습니다");								
		}	
		
		// 세션에 저장된 회원 정보에서도 이미지 경로를 기본 이미지나 null로 변경해야 프로필삭제가 바로반영된다
		Member mvo = (Member) session.getAttribute("mvo");
		mvo.setMemProfile("");            // 이미지 경로 초기화
	    session.setAttribute("mvo", mvo); // 세션 갱신
		
		return "redirect:/member/updateForm";
	}
					
	
	



}




