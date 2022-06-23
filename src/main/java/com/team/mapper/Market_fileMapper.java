package com.team.mapper;

import java.util.List;

import com.team.domain.Market_fileVO;
import com.team.domain.UserVO;

public interface Market_fileMapper {

	public int insert(Market_fileVO mfvo);

	public List<String> getByMno(int mno);

	public void deleteByMno(int mno);

	public void removeByUserid(UserVO vo);

}
