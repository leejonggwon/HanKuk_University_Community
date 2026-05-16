package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

//VO: 값을 담는 객체(Value Object)
@ToString
@AllArgsConstructor 
@NoArgsConstructor 
@Data //Getter Setter
public class Message {
	
	private int msgIdx;
	private String toID;

	private String fromID;
	private String fromName;
	private String fromMajor;
	
	private String msgTitle;
	private String msgContent;
	private Date msgDate; //java.util
	
	private String attached_data;
	private int readStatus;
	private int arriveStatus;
	private int delToID;
	private int delFromID;

}
