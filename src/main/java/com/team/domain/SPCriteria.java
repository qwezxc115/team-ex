package com.team.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SPCriteria {

	private int pageNum;
	private int amount;

	private String category;	
	
	public SPCriteria() {
		this(1, 20);
	}

	public SPCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getFrom() {
		return amount * (pageNum - 1);
	}
	
}
