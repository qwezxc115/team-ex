package com.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.team.domain.CBCriteria;
import com.team.domain.CBoardVO;

public interface CBoardService {

	//게시글 저장 
	public void cbregister(CBoardVO cboard);
	

	//게시글 저장 + 파일 저장 
	public void cbfregister(CBoardVO cboard, MultipartFile file);
	
	//게시글 읽어오기 
	public CBoardVO getcb(Long bno);

	
	//마이페이지 게시글 리스트 가져오기 
	public List<CBoardVO> getcbList(String writer);
	
	//게시글 리스트 가져오기 
	public List<CBoardVO> getcbList(CBCriteria cri);
	
	//게시글 총 갯수
	public int getcbToal(CBCriteria cri);
	
	
	
	//게시글 수정 
	public boolean cbmodify(CBoardVO cboard);
	
	
	//게시글 파일 수정
	public boolean cbfmodify(CBoardVO cboard, MultipartFile file);
	
	//게시글 삭제 
	public boolean cbremove(Long bno);

	//메인자유게시판 게시글조회
	public List<CBoardVO> getCbMainList();
	
}
