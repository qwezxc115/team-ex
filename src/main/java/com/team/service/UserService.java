package com.team.service;

import com.team.domain.UserVO;

public interface UserService {

	//데이터 추가 
	boolean insert(UserVO vo);
	
	//데이터 가져오기 
	UserVO read(String name);
	
	//데이터 수정 
	boolean modify(UserVO vo);
	boolean modifyPassword(UserVO vo, String oldPassword);
	boolean modifyPw(UserVO vo);
	
	//데이터 삭제 
	boolean remove(UserVO vo);
	boolean remove(UserVO vo, String inputPassword);
	
	//아이디 찾기
	UserVO findId(UserVO vo);

	//비밀번호 찾기
	UserVO findPw(UserVO vo);

	//비밀번호 변경
	boolean updatePw (UserVO vo);

	//이메일발송
	public void sendEmail(UserVO vo, String div) throws Exception;

}
