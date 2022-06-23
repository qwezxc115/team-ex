package com.team.mapper;

import java.util.List;

import com.team.domain.Store_fileVO;
import com.team.domain.UserVO;

public interface Store_fileMapper {

	public int insert(Store_fileVO sfvo);

	public List<String> getByPno(Long pno);

	public void deleteByPno(Long pno);

	public void removeByUserid(UserVO vo);

}