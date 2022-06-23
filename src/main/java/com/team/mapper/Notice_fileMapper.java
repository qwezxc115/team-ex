package com.team.mapper;

import java.util.List;

import com.team.domain.Notice_fileVO;


public interface Notice_fileMapper {
	
	public int insert(Notice_fileVO nfvo);
	
	public List<String> getByNno(int nno);
	
	public int deleteByNno(int nno);
}
