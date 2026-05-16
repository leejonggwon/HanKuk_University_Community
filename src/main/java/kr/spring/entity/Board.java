package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
//VO: 값을 담는 객체(Value Object)
@ToString
@AllArgsConstructor //클래스의 모든 필드를 매개변수로 받는 생성자
@NoArgsConstructor //반드시필수: MyBatis가 객체형태로 만들수 있기때문에 (매개변수가 없는 생성자)
@Data //Getter Setter
public class Board {
	
	private int idx;
	private String memID;
	private String category;
	private String title;
	private String content;
	private String writer;
	private String memMajor;
	private Date indate; //java.util 
	private int count;
	private int likeCount;
	
	private String imgpath;
	private String attached_data; //첨부파일
	
	private String originImgpath;
	private String originAttached_data;
	
	private int boardGroup;     //댓글그룹
	private int boardSequence;  //댓글순서
	private int boardLevel;     //댓글단계: 원본인지, 댓글인지, 댓글의 댓글인지를 구분
	private int boardAvailable; //댓글 삭제 여부

}


