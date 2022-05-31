package com.dw.board.utils;

import lombok.Data;

@Data
public class PageHandler {

	//-- limit #{startPage}, #{pageSize}
	// 이때 startPage는 0부터 시작해야 하기때문에 서비스로직에서 -1
	private int total; // 전체 게시물 수
	private int pageNum; // 현재 페이지
	private int pageSize; // 1페이지당 최대 게시물 수
	private int startPage; // 현재블록 첫 페이지
	private int endPage; // 현재블록 마지막 페이지
	private boolean hasPreviousPage = true; // 이전버튼 유무
	private boolean hasNextPage = true; // 다음버튼 유무
	private int nowBlock; // 현재 블록
	private int lastBlock; // 마지막 블록
	private int navigaterPages; //한 블록 최대 페이지 수
	
	
	/**
	 * @return int
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 총 페이지 수
	 */
	public int calcPage(int total, int pageSize) {
		// 총 페이지 수 = 전체 게시물 수 / 1페이지 최대 게시물 수
		int pages = total/pageSize;
		if(total%pageSize > 0) ++pages;
		return pages;
	}
	
	/**
	 * 
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 현재 페이지 블록 알아내기
	 */
	public void setNowBlock(int pageNum, int navigatePages) {
		// 현재 페이지 블록 = 현재페이지/한 블록 최대 페이지 수
		this.nowBlock = pageNum/navigatePages;
		if(pageNum % navigaterPages > 0) ++this.nowBlock;
	}
	
	/**
	 * 
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 마지막 블록 알아내기
	 */
	public void setLastBlock(int total) {
		// 마지막블록 = 전체 게시물 수/(한 블록 최대 페이지 수 * 1페이지 최대 게시글 수)
		this.lastBlock = total / (this.navigaterPages * this.pageSize);
		if(total % (this.navigaterPages * this.pageSize) > 0)  ++this.lastBlock;
	}

	/**
	 * @param nowBlock
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 현재블록의 처음 페이지
	 * 다음 버튼을 눌렀을 때 다음 블록의 시작을 정해줌
	 */
	public void setStartPage(int nowBlock) {
		// 시작페이지 = (현재 블록 * 한 블록 최대 페이지 수) - (한 블록 최대 페이지 수 - 1)
		// nowBlock의 제일 첫 페이지
		this.startPage = (nowBlock * this.navigaterPages) - (this.navigaterPages - 1);
	}
	
	/**
	 * @param lastBlock
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 현재블록의 마지막 페이지
	 */
	public void setEndPage(int lastBlock) {
		// 마지막 페이지 = 현재블록 * 한블록 최대 페이지 수
		this.endPage = nowBlock * this.navigaterPages;
		if(nowBlock == this.lastBlock) {
			this.endPage = total;
		}
	}

	/**
	 * @param pageNum
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 이전버튼, 다음버튼 유무 판단
	 */
	public void setPreNext(int pageNum) {
		
		// 마지막 블록 == 1 이라면 이전, 다음버튼 없음
		if(this.lastBlock == 1) {
			setHasPreviousPage(false);
			setHasNextPage(false);
		}
		
		// 마지막 블록 > 1 & 마지막 블록 == 지금 블록
		// 현재 블록이 마지막 블록일 경우
		if(this.lastBlock > 1 && this.lastBlock == this.nowBlock) {
			setHasPreviousPage(true);
			setHasNextPage(false);
		}
		// 마지막 블록 > 1 & 현재 페이지 <= 한블록 최대 페이지 수
		// 
		if(this.lastBlock > 1 && pageNum <= this.navigaterPages) {
			setHasPreviousPage(false);
			setHasNextPage(true);
		}
	}

}

