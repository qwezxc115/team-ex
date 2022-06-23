package com.team.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.team.domain.UserVO;
import com.team.mapper.UserMapper;
import com.team.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j 
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO vo = mapper.read(username);

		log.info(vo);
		if (vo == null) {
			throw new UsernameNotFoundException("사용자를 찾을 수 없습니다. username: " + username);
		}

		return new CustomUser(vo);
	}
}
