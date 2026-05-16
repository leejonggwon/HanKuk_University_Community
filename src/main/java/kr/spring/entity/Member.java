package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor 
@NoArgsConstructor 
@Data 
public class Member {
	
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;

	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	private int memStatus;
	
	private String memMajor;
	private String memUserCode;
	private String memRole;
	
	

}








