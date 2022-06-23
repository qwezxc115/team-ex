package com.team.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EBCriteria {

	
	

	private int pageNum;
	private int amount;
	
//	private String type;
//	private String keyword;
//	
	
	public EBCriteria() {
		this(1, 9);
	}
	
	public EBCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//몇번을 구하는 코드   LIMIT 
	public int getFrom() {
		return amount * (pageNum - 1);
	}
	
//	public String[] getTypeArr() {
//		if (type == null) {
//			return new String[] {};
//		} else {
//			String[] types = type.split("");
//			return types;
//		}
//	}
	
}
