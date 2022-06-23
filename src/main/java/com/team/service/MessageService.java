package com.team.service;

import java.util.List;

import com.team.domain.MessageVO;


public interface MessageService {
    public boolean mesinsert(MessageVO vo);
	public List<MessageVO> getListSend(MessageVO vo, Integer page);
	public List<MessageVO> getListReceive(MessageVO vo, Integer page);
	
	public void mesdelete(MessageVO vo);
	public List<MessageVO> getSearchMessageList(String receivesearchValue);
	
	//리스트
//	public List<MessageVO> getList(Criteria cri);
	
	//총 페이지
//	public int getTotal(Criteria cri);
	int getTotalListSend(MessageVO vo);
	int getTotalListReceive(MessageVO vo);


}