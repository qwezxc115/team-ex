package com.team.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {

	private String userid;
	private String userpw;
	private String userName;
	private String userPhone;
	private String userEmail;
	private String CompanyRegistrationNumber;
	private String useradd;
	private Date regdate;
	private Date updateDate;
	private boolean enabled;
	
	//유저에있는권한들 
	private List<AuthVO> authList;
	
	//
	private AuthVO auth;
	
	
}
