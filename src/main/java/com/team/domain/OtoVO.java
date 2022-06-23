package com.team.domain;

import java.util.Date;

import java.util.List;

import lombok.Data;

@Data
public class OtoVO {


	//one to one의 o사용
	//question의 q사용
	private int qono;  //게시글 번호


    private String otitle;
    private String userid;
    private String odetail;
    private Date oregdate;

    private List<String> fileName;

}
