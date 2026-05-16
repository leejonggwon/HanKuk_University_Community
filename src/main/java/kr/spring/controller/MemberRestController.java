package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Member;
import kr.spring.service.MemberService;

@RestController
@RequestMapping("/member/*")
public class MemberRestController {
	
	@Autowired
	private MemberService service;
	
	
	//@ResponseBody: 리턴값을 JSP 같은 뷰 이름으로 해석하지 않고, 클라이언트에게 바로 값(데이터)으로 보낸다.
	@PostMapping("/registerCheck")
	@ResponseBody
	public int registerCheck(@RequestParam("memID") String memID){ 
		System.out.println("아이디 중복체크");
		Member m = service.registerCheck(memID);
		//m == null → 아이디 중복가능
		//m != null → 기존에 아이디 사용 불가능
		if(m != null || memID.equals("")) {
			return 0;
		}else {
			return 1;
		}
	}
	
	
	// 작성자 정보 조회/반환
	@GetMapping("/writerInfo")
	@ResponseBody
	public Member writerInfo(@RequestParam String memID) {  
		
		//JSON 형태로 반환된다 (memName, memProfile 등 포함)
		Member writerInfo = service.writerInfo(memID); 
	    return writerInfo;
	}
	
	
	// 메시지 작성자 프로필 조회
	@GetMapping("/fromIDInfo")
	@ResponseBody
	public Member fromIDInfo(@RequestParam String memID) {  
		System.out.println("메시지 작성자 프로필 조회");
		//JSON 형태로 반환된다 (memName, memProfile 등 포함)
		Member fromIDInfo = service.fromIDInfo(memID); 
	    return fromIDInfo;
	}
	
	
}


