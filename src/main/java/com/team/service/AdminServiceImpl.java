package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.team.domain.AuthVO;
import com.team.domain.UserVO;
import com.team.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;

	//				일반회원 관련

	//일반회원 리스트조회
	@Override
	public List<UserVO> getUserlist() {
		return mapper.getUserlist();
	}

	//일반회원 추가
	@Override
	public boolean getUserinsert(UserVO user) {

		// 패스워드 암호화
		user.setUserpw(encoder.encode(user.getUserpw()));
		int cnt = mapper.getUserinsert(user);

		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(user.getUserid());
		avo.setAuth("ROLE_USER");
		mapper.getUserinsertAuth(avo);

		return cnt == 1;
	}

	//일반회원 정보수정
	@Override
	public void Userupdate(UserVO vo) {
		mapper.Userupdate(vo);
	}

	//일반회원 회원탈퇴
	@Override
	public void Userdelete(UserVO vo) {
		mapper.Userdelete(vo);
	}

	// 				관리자 관련

	// 관리자 계정 추가
	@Override
	public boolean getAdmininsert(UserVO admin) {

		// 패스워드 암호화
		admin.setUserpw(encoder.encode(admin.getUserpw()));
		int cnt = mapper.getAdmininsert(admin);

		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(admin.getUserid());
		avo.setAuth("ROLE_ADMIN");
		mapper.getAdmininsertAuth(avo);

		return cnt == 1;
	}

	//관리자 리스트조회
	@Override
	public List<UserVO> getAdminlist() {
		return mapper.getAdminlist();
	}

	//관리자회원 정보수정
	@Override
	public void Adminupdate(UserVO vo) {
		mapper.Adminupdate(vo);
	}

	//관리자회원 회원탈퇴
	@Override
	public void Admindelete(UserVO vo) {
		mapper.Admindelete(vo);
	}

}
