package com.team.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Order_detailVO {
	
	private long ono;
	private long pno;
	private long cno;
	private String userid;
	private long cartstock;
	private Date orderdate;
	
	private String title;
	private long price;
	private String detail;
	private long money;

	private long sumMoney;
	
	private List<Order_detailVO> OrderVOList;
}
