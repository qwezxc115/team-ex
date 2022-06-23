package com.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.domain.Criteria;
import com.team.domain.NoticeVO;
import com.team.domain.OtoAnswerVO;
import com.team.domain.OtoVO;

public interface CsMapper {
	public List<OtoVO> getotolist(@Param("cri")Criteria cri, @Param("userid")String userid);

	public int otowriting(OtoVO ovo);

	public OtoVO otoreading(int qono);

	public int otodelete(int qono);

	public OtoAnswerVO otoanswer(OtoAnswerVO vo);

	public List<NoticeVO> getNoticeList(Criteria cri);

	public int noticeWriting(NoticeVO nvo);

	public NoticeVO noticeReading(int nno);

	public int noticeModify(NoticeVO nvo);

	public int noticeDelete(int nno);

	// 페이징 : 게시글 총 갯수
	public int getTotalCountN(Criteria cri);
	public int getTotalCountO(OtoVO vo);
	
	//메인공지사항 글조회
	public List<NoticeVO> getNoticeMainList();
	
}
