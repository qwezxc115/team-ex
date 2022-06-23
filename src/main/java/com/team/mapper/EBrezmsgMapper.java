package com.team.mapper;

import java.util.List;

import com.team.domain.EBrezmsgVO;

public interface EBrezmsgMapper {

	//예약 내역 저장 
	public int EBrezmsg(EBrezmsgVO ebrezvo);
	
	//예약 내역 읽어오기 
	public EBrezmsgVO readrezmsg(long rno);
	
	//예역 리스트 불러오기 
	public List <EBrezmsgVO> getrezlist(String writer);
	public List <EBrezmsgVO> getreaderrezlist(String reader);
	
	//예약내역 지우기 
	public int rezdelete(long rno);
	
	
}
