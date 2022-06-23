package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CBoardVO {
//커뮤니티자유게시판 
	
	private long bno;
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private Date regdate;
	private Date updateDate;
	private int replyCnt;
	private String fileName;
	private String cbcategory;
	
}
