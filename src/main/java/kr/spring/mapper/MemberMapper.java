package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper
public interface MemberMapper {
	
	//로그인
	public Member login(Member vo);

	//프로필사진 업로드
	public void profileUpdate(Member vo);

	//업데이트
	public int update(Member m);

	//작성자 정보를 조회/반환
	public Member writerInfo(String writer);

	//회원가입
	public int join(Member m);

	//아이디중복체크
	public Member registerCheck(String memID); 
	
	//메시지 작성자 프로필 조회
	public Member fromIDInfo(String memID);

	//프로필이미지삭제
	public int imageDelete(String memID);

	//비밀번호변경
	public int passwordUpdate(Member m);
}
