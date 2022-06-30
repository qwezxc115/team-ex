package com.team.mapper;

import java.util.List;

import com.team.domain.AuthVO;
import com.team.domain.UserVO;

public interface AdminMapper {
	
	// 일반회원 관련
	public List<UserVO> getUserlist();	
	public int getUserinsert(UserVO user);
	public int getUserinsertAuth(AuthVO userauth);
	public void Userupdate(UserVO vo);
	public void Userdelete(UserVO vo);
	
	// 관리자 관련
	public List<UserVO> getAdminlist();
	public int getAdmininsert(UserVO admin);
	public int getAdmininsertAuth(AuthVO adminauth);
	public void Adminupdate(UserVO vo);
	public void Admindelete(UserVO vo);
	
	
}
