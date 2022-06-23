package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.domain.EBrezmsgVO;
import com.team.mapper.EBrezmsgMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class EBrezmsgServiceImpl  implements EBrezmsgService{
	
	
	@Setter (onMethod_= @Autowired)
	private EBrezmsgMapper mapper;
	
//    @Setter(onMethod_ = @Autowired)
//    private UserMapper userMapper;
//	
    
    
	//예약 내역 저장 
	@Override
	public boolean  rezregister(EBrezmsgVO ebrezvo) {
		
		int cnt = mapper.EBrezmsg(ebrezvo);
		
		return cnt == 1 ;
	}

	
	//예약 내역 읽어오기  
	@Override
	public EBrezmsgVO getrezmsg(Long rno) {
		
		log.info(mapper);
		
		return mapper.readrezmsg(rno);
	}
	
	
	//예약 내역 리스트 가져오기 
	@Override
	public List<EBrezmsgVO> getrezlist(String writer) {
		
		log.info(writer);
		return mapper.getrezlist(writer);
	}

	
	@Override
	public List<EBrezmsgVO> getreaderrezlist(String reader) {
		
		log.info(reader);
		return mapper.getreaderrezlist(reader);
	}
	
	//예약 내역 삭제 
	@Override
	public boolean rezremove(Long rno) {
		
		int cnt = mapper.rezdelete(rno);
		return cnt == 1;
	}


	
}
