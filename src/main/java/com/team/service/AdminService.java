package com.team.service;

import java.util.List;

import com.team.domain.UserVO;

public interface AdminService {
	
	// 기본회원관련
	List<UserVO> getUserlist();
	boolean getUserinsert(UserVO user);
	void Userupdate(UserVO vo);
	void Userdelete(UserVO vo);

	// 관리자관련
	List<UserVO> getAdminlist();
	boolean getAdmininsert(UserVO user);
	void Adminupdate(UserVO vo);
	void Admindelete(UserVO vo);
	
}
