package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OtoAnswerVO {
	
	//answer의 a사용
	//question의 q사용
	private int aono;  
	private int qono; 
	private String content;
	private String userid;
	private Date regdate;

}
