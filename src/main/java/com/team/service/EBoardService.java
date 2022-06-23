package com.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.team.domain.EBCriteria;
import com.team.domain.EBoardVO;

public interface EBoardService {

	//글 저장 
	public void ebregister(EBoardVO eboard);
	//글 저장 + 파일 저장 
	public void ebfregister(EBoardVO eboard,MultipartFile file);
	
	//글 읽어오기 
	public EBoardVO geteb(Long eno);
	//글 리스트  가져오기 
	public List<EBoardVO> getebList(EBCriteria cri);
	//글 갯수 
	public int getebToal(EBCriteria cri);
	
	
	//글 수정 
	public boolean ebmodify(EBoardVO eboard);
	//글 첨부 파일 수정 
	public boolean ebfmodify(EBoardVO eboard, MultipartFile file);
	
	//글 삭제
	public boolean ebremove(Long eno);
	
}
