package com.team.mapper;

import java.util.List;

import com.team.domain.OtofileVO;

public interface OtofileMapper {

	public int insert(OtofileVO ofvo);
	
	public List<String> getByQono(int qono);
	
}
