package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	
	private Long cno;
	private String userid;
	private Long pno;
	private Long cartstock;
	private Date adddate;
	
	private String title;
	private long price;
	private String detail;
	private long money;

	private long sumMoney;
}
