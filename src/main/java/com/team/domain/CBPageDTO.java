package com.team.domain;

import lombok.Getter;

@Getter
public class CBPageDTO {
	
	
	private CBCriteria cri;
	
	private int startPage; //현재 페이지 시작 페이지 
	private int endPage; //현재 페이지 종료 페이지 
	
	private boolean prev; //이전페이지버튼 표시 유무! 
	private boolean next; //다음페이지버튼 표시 유무! 
	
	private int total; //총게시물 수 
	
	public CBPageDTO(CBCriteria cri, int total) {
		this.cri =cri;
		int current = cri.getPageNum();
		int numPerPage = cri.getAmount();
		
		//현재 페이지가 1~10 이면 
		//맨 왼쪽은 1, 맨오른쪽은 10
		
		//현재 페이지가 11~20 이면
		//맨 왼쪽은 11, 맨오른쪽은 20
		
		this.endPage = ((current-1)/ 10 + 1 ) * 10;
		this.startPage = endPage - 9;
		
		
		int realEnd  = total / numPerPage;
		
		
		//가장 마지막 페이지 
		if(total  % numPerPage != 0 ) {
			 realEnd  = realEnd + 1;
		}
		
		//마지막페이지와  가장마지막페이지 비교 
		this.endPage = Math.min(endPage, realEnd);

		// 이전, 다음 버튼 표시 여부
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
}
