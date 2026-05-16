package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor //클래스의 모든 필드를 매개변수로 받는 생성자
@NoArgsConstructor //반드시필수: MyBatis가 객체형태로 만들수 있기때문에 (매개변수가 없는 생성자)
@Data //Getter Setter
public class Comment {
	
	private int cmtIdx;        //댓글번호
	private int idx;           //게시글번호 Board
	private String cmtContent; //댓글내용	
	private String memID;      //아이디 Member
	private String memName;    //이름 Member
	private String memMajor;    //이름 Member
	
	private String memProfile; //프로필이미지 Member
	private Date cmtIndate;    //댓글작성된 시간
	private int cmtAvailable;  //댓글삭제여부(0:삭제상태)
	
}
