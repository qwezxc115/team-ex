package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishVO {
	private Long wno;
	private String userid;
	private Long pno;
	private Date adddate;
	
// 제품에서 불러옵니다.	
	private String title;
	private long price;
	private String detail;

}