package com.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.team.domain.Criteria;
import com.team.domain.NoticeVO;

public interface CsService {

	public List<NoticeVO> getNoticeList(Criteria cri);
	// 총 페이지

	public int getTotalN(Criteria cri);

	public void noticeWriting(NoticeVO nvo);

	public void noticeWriting(NoticeVO nvo, MultipartFile[] notice_file);

	public NoticeVO noticeReading(int nno);

	public boolean noticeModify(NoticeVO nvo);

	public boolean noticeModify(NoticeVO nvo, MultipartFile[] notice_file);

	public boolean noticeDelete(int nno);

	//메인공지사항 글조회
	public List<NoticeVO> getNoticeMainList();

}
