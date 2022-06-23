package com.team.mapper;

import java.util.List;

import com.team.domain.Criteria;
import com.team.domain.MarketVO;

public interface MarketMapper {

	// 데이터 추가 
	public int insert(MarketVO mvo);
	
	public int insertSelectKey(MarketVO mvo); 
	
	// 데이터 조회
	public MarketVO read(int mno);

	
	// 데이터 수정 
	public int update(MarketVO mvo);
	
	// 데이터 삭제
	public int delete(int mno);	

	
	// 데이터 리스트
	public List<MarketVO> getList();
		
	// 페이징 : 게시글 총 갯수
	public int getTotalCount(Criteria cri);
	
	// 페이징 리스트

	public List<MarketVO> getListWithPaging(Criteria cri);

	//마이페이지 리스트 
	public List<MarketVO> getmkList(String writer);

	//메인중고마켓 게시글조회
	public List<MarketVO> getMarketMainList();
	
}
