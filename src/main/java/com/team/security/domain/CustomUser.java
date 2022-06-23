package com.team.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.team.domain.UserVO;

import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
public class CustomUser extends User {

	//User 정보를 꺼내서 볼수있게 
	@Getter
	@Setter
	private UserVO user;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(UserVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		user = vo;
	}
}
