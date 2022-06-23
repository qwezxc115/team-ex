package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.domain.MessageVO;
import com.team.domain.UserVO;
import com.team.mapper.MessageMapper;
import com.team.mapper.UserMapper;

import lombok.Setter;

@Service
public class MessageServiceImpl implements MessageService {


	
    @Setter(onMethod_ = @Autowired)
    private MessageMapper mapper;
    
    @Setter(onMethod_ = @Autowired)
    private UserMapper userMapper;

    @Override
    public boolean mesinsert(MessageVO vo) {
        
    	UserVO reader = userMapper.read(vo.getReader());
    	
    	if (reader == null) {
    		return false;
    	}
    	
    	int cnt = mapper.mesinsert(vo);
        
        return cnt == 1;
    }
    
    //쪽지 삭제
    @Override
    public void mesdelete(MessageVO vo) {
    	mapper.mesdelete(vo);
    }
	

	@Override
	public List<MessageVO> getListSend(MessageVO vo, Integer page) {
		return mapper.getListSend(vo, page);
	}
	
	@Override
	public int getTotalListSend(MessageVO vo) {
		return mapper.getTotalListSend(vo);
	}


	@Override
	public List<MessageVO> getListReceive(MessageVO vo, Integer page) {
		return mapper.getListReceive(vo, page);
	}
	
	@Override
	public int getTotalListReceive(MessageVO vo) {
		return mapper.getTotalListReceive(vo);
	}
	
	
	
	
	//쪽지 검색
	@Override
	public List<MessageVO> getSearchMessageList(String receivesearchValue) {
		
		return mapper.getSearchMessageList(receivesearchValue);
	}
	

	
//	@Override
//	public List<MessageVO> getList(Criteria cri) {
//		return mapper.getListWithPaging(cri);
//	}
//	
//	public int getTotal(Criteria cri) {
//		return mapper.getTotalCount(cri);
//	}
	
	
}