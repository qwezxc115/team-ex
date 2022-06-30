package com.team.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.domain.AuthVO;
import com.team.domain.UserVO;
import com.team.mapper.CBFileMapper;
import com.team.mapper.CBoardMapper;
import com.team.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserServiceImpl implements UserService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;

	@Setter(onMethod_ = @Autowired)
	private CBoardMapper cboardmapper;

	@Setter(onMethod_ = @Autowired)
	private CBFileMapper filemapper;

	@Setter(onMethod_ = @Autowired)
	private CBoardService cboardService;

	//자바 메일 발송

	@Override
	@Transactional
	public boolean insert(UserVO vo) {

		// 패스워드 암호화
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		int cnt = mapper.insert(vo);

		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(vo.getUserid());
		avo.setAuth("ROLE_USER");
		mapper.insertAuth(avo);

		return cnt == 1;
	}

	@Override
	public UserVO read(String name) {

		return mapper.read(name);
	}

	@Override
	public boolean modify(UserVO vo) {

		int cnt = mapper.update(vo);
		return cnt == 1;

	}

	@Override
	public boolean modifyPassword(UserVO vo, String oldPassword) {

		UserVO userinfo = mapper.read(vo.getUserid());

		if (encoder.matches(oldPassword, userinfo.getUserpw())) {

			return modifyPw(vo);
		}

		return false;
	}

	@Override
	public boolean modifyPw(UserVO vo) {

		vo.setUserpw(encoder.encode(vo.getUserpw()));

		int cnt = mapper.modifyPassword(vo);

		return cnt == 1;
	}

	@Override
	public boolean remove(UserVO vo, String inputPassword) {

		UserVO userinfo = mapper.read(vo.getUserid());

		log.info(inputPassword);
		log.info(vo);
		if (encoder.matches(inputPassword, userinfo.getUserpw())) {
			return remove(vo);
		}

		return false;
	}

	@Override
	public boolean remove(UserVO vo) {

		//회원 삭제 
		int cnt = mapper.remove(vo);
		return cnt == 1;
	}

	//아이디 찾기
	@Override
	public UserVO findId(UserVO vo) {
		return mapper.findId(vo);
	}

	//비밀번호 찾기
	@Override
	public UserVO findPw(UserVO vo) {
		return mapper.findPw(vo);
	}

	//비밀번호 변경
	@Override
	public boolean updatePw(UserVO vo) {
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		int cnt = mapper.updatePw(vo);
		return cnt == 1;
	}

	@Override
	public void sendEmail(UserVO vo, String div) throws Exception {

	}

}
