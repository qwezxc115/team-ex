package com.team.domain;

import lombok.Data;

// 은비 8-16 수정
@Data
public class OtofileVO {
	
	//one to one의 o사용
	//question의 q사용
	private int id;  //파일id
	private int qono;  //게시글 번호
	private String fileName;
    
}
