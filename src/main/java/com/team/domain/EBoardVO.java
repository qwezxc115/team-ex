package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EBoardVO {

	
	
	private long eno;
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private String addRegion ;
	private String addCi ;
	private String addGu;
	private Date regdate;
	private Date updateDate;
	private String fileName;
	
	
	
}
