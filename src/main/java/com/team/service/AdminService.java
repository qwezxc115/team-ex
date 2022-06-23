package com.team.service;

import java.util.List;

import com.team.domain.OtoAnswerVO;
import com.team.domain.OtoVO;
import com.team.domain.SProductVO;
import com.team.domain.UserVO;

public interface AdminService {
	
	// 기본회원관련
	List<UserVO> getUserlist();
	boolean getUserinsert(UserVO user);
	void Userupdate(UserVO vo);
	void Userdelete(UserVO vo);

	// 업체관련
	List<UserVO> getComplist();
	boolean getCompinsert(UserVO comp);
	void Compupdate(UserVO vo);
	void Compdelete(UserVO vo);
	
	// 상품목록관련
	List<SProductVO> getProductlist();
	void Productupdate(SProductVO vo);
	void Productdelete(SProductVO vo);
	boolean getProductinsert(SProductVO comp);
	
	// 문의내역관련
	List<OtoVO> getOtolist();
	void Otoanswer(OtoAnswerVO vo);
	
	// 관리자관련
	List<UserVO> getAdminlist();
	boolean getAdmininsert(UserVO user);
	void Adminupdate(UserVO vo);
	void Admindelete(UserVO vo);
	
}
