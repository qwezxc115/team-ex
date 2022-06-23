package com.team.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MarketVO {

	private int mno;

	// userid 
	private String mwriter;
	private String mtitle;
	private int mprice;
	private String mdetail;
	private String mstate;
  
	private String msold;
	private Date mregdate;
	private String maddress;
	
	// 은비 파일
	
	private List<String> fileName; 
	
}
