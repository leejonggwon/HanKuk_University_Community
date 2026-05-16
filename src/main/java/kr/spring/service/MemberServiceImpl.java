package kr.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
		//로그인
		@Override
		public Member login(Member vo) {
			Member mvo = mapper.login(vo);
			return mvo; //서비스는 뷰네임이 아닌 데이터를 돌려준다
			            //컨트롤러는 받아온 데이터로 뷰를 만들어서 돌려준다
		}

		@Override
		public void profileUpdate(Member vo) {
			mapper.profileUpdate(vo);
			
		}

		@Override
		public int update(Member m) {
			return  mapper.update(m);
			
			
		}

		//작성자 정보를 조회/반환
		@Override
		public Member writerInfo(String memID) {		
			return mapper.writerInfo(memID);
		}

		//회원가입
		@Override
		public int join(Member m) {
			return mapper.join(m);
		}

		//아이디중복체크
		@Override
		public Member registerCheck(String memID) {
			return mapper.registerCheck(memID);
		}
	
		//메시지 작성자 프로필 조회
		@Override
		public Member fromIDInfo(String memID) {
			return mapper.fromIDInfo(memID);
		}

		//프로필이미지삭제
		@Override
		public int imageDelete(String memID) {	
			return mapper.imageDelete(memID);
		}

		//패스워드변경
		@Override
		public int passwordUpdate(Member m) {
			return mapper.passwordUpdate(m);
		}


}
