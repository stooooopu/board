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
	private boolean hasPreviousPage; // 이전버튼 유무
	private boolean hasNextPage; // 다음버튼 유무
	private int navigaterPages; //한 블록 최대 페이지 수
	private int nowBlocks; // 현재 블록
	private int lastBlocks; // 마지막 블록
	
	
	/**
	 * @return int
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 총 페이지 수
	 */
	public int calcPage(int total, int pageSize) {
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
	public void setNowBlock(int pageNum, int navigaterPages) {
		this.nowBlocks = pageNum/navigaterPages;
		if(pageNum % navigaterPages > 0) ++this.nowBlocks;
	}
	
	/**
	 * 
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 마지막 블록 알아내기
	 */
	public void setLastBlock(int total) {
		this.lastBlocks = total / (this.navigaterPages * this.pageSize);
		if(total % (this.navigaterPages * this.pageSize) > 0)  ++this.lastBlocks;
	}

	/**
	 * @param nowBlock
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 현재블록의 처음 페이지
	 */
	public void setStartPage(int nowBlock) {
		this.startPage = (nowBlock * this.navigaterPages) - (this.navigaterPages - 1);
	}
	
	/**
	 * @param lastBlock
	 * @author : ji_U
	 * @date : 2022. 5. 31.
	 * comment : 현재블록의 마지막 페이지
	 */
	public void setEndPage(int lastBlock) {
		this.endPage = nowBlocks * this.navigaterPages;
		if(nowBlocks == this.lastBlocks) {
			this.endPage = total;
		}
	}

	public void setPreNext(int pageNum) {
		if(this.lastBlocks == 1) {
			setHasPreviousPage(false);
			setHasNextPage(false);
		}
		if(this.lastBlocks > 1 && this.lastBlocks == this.nowBlocks) {
			setHasPreviousPage(true);
			setHasNextPage(false);
		}
		if(this.lastBlocks > 1 && pageNum <= navigaterPages) {
			setHasPreviousPage(false);
			setHasNextPage(true);
		}
	}

}

