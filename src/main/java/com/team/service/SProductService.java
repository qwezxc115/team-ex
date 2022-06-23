package com.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.team.domain.SPCriteria;
import com.team.domain.SProductVO;

public interface SProductService {
	
	// 글 쓰기 : 데이터 추가 
	public void register(SProductVO svo);

	// 글 쓰기 : 파일 데이터 추가 
	public void register(SProductVO svo, MultipartFile[] store_file);

	// 읽어오기 : 데이터 조회
	public SProductVO read(Long pno);

	// 글 수정 
	public boolean modify(SProductVO svo);
	
	// 글 수정 & 파일 데이터 수정
	public boolean modify(SProductVO svo, MultipartFile[] store_file);

	// 글 삭제
	public boolean remove(Long pno);
	
	// 카테고리 리스트
	public List<SProductVO> getCateList(SPCriteria cri);

	// 총 페이지
	public int getTotal(SPCriteria cri);
	
	//메인스토어 게시글조회
	public List<SProductVO> getsproductMainList();
	
	
}