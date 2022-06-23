package com.team.mapper;

import java.util.List;

import com.team.domain.SPCriteria;
import com.team.domain.SProductVO;

public interface SProductMapper {

	// 데이터 추가 
	public int insert(SProductVO svo);
	
	public int insertSelectKey(SProductVO svo); 
	
	// 데이터 조회
	public SProductVO read(long pno);
	
	
	// 데이터 수정 
	public int update(SProductVO svo);
	
	// 데이터 삭제
	public int delete(long pno);	
	
	// 데이터 리스트
	public List<SProductVO> getList();
		
	// 페이징 : 게시글 총 갯수
	public int getTotalCount(SPCriteria cri);

	
	// 카테고리 리스트
	public List<SProductVO> getCateListWithPaging(SPCriteria cri); 
	
	//메인스토어 게시글조회
	public List<SProductVO> getsproductMainList(); 
	
}
