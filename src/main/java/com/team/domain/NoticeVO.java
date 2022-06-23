package com.team.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int nno;  //게시글 번호
    private String ntitle;
    private String userid;
    private String ndetail;
    private Date nregdate;
    
	private List<String> fileName; 
    
}
