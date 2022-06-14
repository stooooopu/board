package com.dw.board;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.utils.PageHandler;

@SpringBootTest
class BoardApplicationTests {
	@Autowired
//	private StudentsService service;
	private PageHandler pageHandler;
	
	@Autowired
	private BoardMapper boardMapper;
	
	
	
	@Test
	void contextLoads() {
//		System.out.println("HELLOWORLD");
		
		// 학생 전체조회
//		List<Map<String, Object>> list = service.getAllStudentsMap();
//		System.out.println(list);
		
		// 게시판 카운트 쿼리 호출
		int total = boardMapper.selectAllBoardListTotal(); // SQL COUNT(*) 전체 게시물 수
		System.out.println("total ==> "+total);
		
		int pageNum = 1; // 현재 페이지 번호
		int pageSize = 10; // 한 페이지에 개시물 10개
		int navigatePages = 5; // 한 블록에 5페이지
		
		pageHandler.setTotal(total);
		pageHandler.setPageNum(pageNum);
		pageHandler.setPageSize(pageSize);
		pageHandler.setNavigaterPages(navigatePages);
		// 여기까지가 기본 셋팅
		
		pageHandler.setNowBlock(pageNum);
		int nowBlock = pageHandler.getNowBlock();
		System.out.println("현재 블록 => "+nowBlock);
		
		pageHandler.setLastBlock(total);
		int lastBlock = pageHandler.getLastBlock();
		System.out.println("마지막 블록 => "+lastBlock);
				
		pageHandler.setStartPage(nowBlock);
		int startPage = pageHandler.getStartPage();
		System.out.println("현재블록의 첫 페이지 => "+startPage);
			

		int pages = pageHandler.calcPage(total, pageSize);
		pageHandler.setEndPage(nowBlock, pages);
		int lastPage = pageHandler.getEndPage();
		System.out.println("마지막 페이지 => "+lastPage);
		
		pageHandler.setPreNext(pageNum);
		boolean hasPreviousPage = pageHandler.isHasPreviousPage();
		boolean hasNextPage = pageHandler.isHasNextPage();
		System.out.println("이전 페이지 유무 => "+hasPreviousPage);
		System.out.println("다음 페이지 유무 => "+hasNextPage);
		
		// 데이터가 10만건정도면 limit도 괜찮지만 100만개의 데이터는 느리니까 between사용
		// limit은 전체 데이터 조회를 다 마치고 상위 몇건만 보여주는 것 이기 때문에 비효율적
		int limitStart = ((pageNum-1) * pageSize);
		List<Map<String, Object>> list = boardMapper.selectAllBoardListTest(limitStart, pageSize);
		
		// 게시판 현재 페이지의 작성자 list를 보여줌
		for(Map<String, Object> param : list) {
			String studentsName = (String) param.get("studentsName");
			System.out.println(studentsName);
		}
		
		
		
		
		
		
	}

}
