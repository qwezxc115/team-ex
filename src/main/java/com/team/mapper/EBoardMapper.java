package com.team.mapper;

import java.util.List;

import com.team.domain.EBCriteria;
import com.team.domain.EBoardVO;

public interface EBoardMapper {

	
	
	//게시물 저장 
	public int ebinsertSelectKey(EBoardVO eboard);
	
	//게시물 읽어오기 
	public EBoardVO readeb(long eno);
	
	//게시물 리스트 불러오기 
	public List <EBoardVO> getebList();
	
	//게시물 리스트 불러오기 (페이징 )
	public List <EBoardVO> getebListWithPaging(EBCriteria cri);
	
	//게시물 총 갯수(페이징하기위해서 )
	public int getebTotalCount(EBCriteria cri);
	
	//게시물 지우기 
	public int ebdelete(long eno);
	
	
	//게시물 수정 
	public int ebupdate(EBoardVO eboard);
}
