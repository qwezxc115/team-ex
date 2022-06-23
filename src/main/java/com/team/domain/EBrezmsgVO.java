package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EBrezmsgVO {
	
	private long eno;
	private long rno;
    private String reader;
    private String readerName;
    private String rezdate;
    private String reztime;
    private String writer;
    private String writerName;
    private String content;
    private Date regdate;
    
}
