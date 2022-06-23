package com.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.team.domain.Criteria;
import com.team.domain.MarketVO;

public interface MarketService {
	
	// 글 쓰기 : 데이터 추가 

	public void write(MarketVO mvo);

	// 글 쓰기 : 파일 데이터 추가 
	public void write(MarketVO mvo, MultipartFile[] market_file);

	// 읽어오기 : 데이터 조회
	public MarketVO read(int mno);

	// 글 수정 
	public boolean modify(MarketVO mvo);
	
	// 글 수정 & 파일 데이터 수정
	public boolean modify(MarketVO mvo, MultipartFile[] market_file);

	// 글 삭제
	public boolean remove(int mno);

	// 리스트
	public List<MarketVO> getList(Criteria cri);

	//마이페이지 글 리스트 
	public List <MarketVO> getmkList(String writer);
	
	// 총 페이지
	public int getTotal(Criteria cri);

	//메인중고마켓 게시글조회
	public List<MarketVO> getMarketMainList();

}