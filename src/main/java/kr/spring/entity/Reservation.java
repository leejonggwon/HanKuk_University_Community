package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor 
@NoArgsConstructor 
@Data 
public class Reservation {
	private int rIdx;
	private int seatNum;
	private String seatName;
	private String memID;
	private String memName;
	private Date startTime;
	private Date endTime;
	private int endTimeStatus;
}
