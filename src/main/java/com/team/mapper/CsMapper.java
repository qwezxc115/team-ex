package com.team.mapper;

import java.util.List;

import com.team.domain.Criteria;
import com.team.domain.NoticeVO;

public interface CsMapper {

	public int otodelete(int qono);

	public List<NoticeVO> getNoticeList(Criteria cri);

	public int noticeWriting(NoticeVO nvo);

	public NoticeVO noticeReading(int nno);

	public int noticeModify(NoticeVO nvo);

	public int noticeDelete(int nno);

	// 페이징 : 게시글 총 갯수
	public int getTotalCountN(Criteria cri);

	//메인공지사항 글조회
	public List<NoticeVO> getNoticeMainList();

}
