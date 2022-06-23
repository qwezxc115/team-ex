package com.team.mapper;

import com.team.domain.AuthVO;
import com.team.domain.MessageVO;
import com.team.domain.UserVO;

public interface UserMapper {

	// 데이터추가하기 
	public int insert(UserVO vo);
	public int insertAuth(AuthVO vo);
	
	// 기업
	public int insertB(UserVO vo);
	
	// 데이터조회하기 
	public UserVO read(String userid);
	
	// 데이터 수정하기 
	public int update(UserVO vo);
	//비밀번호 수정 
	public int modifyPassword(UserVO vo);
	
	
	// 데이터 삭제
	public int remove(UserVO vo);
	//public int removeAuth(UserVO vo);
	
	
	// 아이디 찾기
	public UserVO findId(UserVO vo);


	// 비밀번호 찾기
	public UserVO findPw (UserVO vo);
	

	//비밀번호 변경
	public int updatePw(UserVO vo);
	
	// 메세지
	public int msgsend(MessageVO vo);

	public void updatePoint(UserVO vo);
	
	public void updateSpendPoint(UserVO vo);
}
