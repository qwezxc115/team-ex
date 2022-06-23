package com.team.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SProductVO {
	
	private long pno;
	private String category;
	private String userid;
	private String title;
	private long price;
	private String delivery;
	private String detail;
	private String keyword;
	private Date regdate;
	private Date updatedate;
	
	
	private List<String> fileName; 
}

