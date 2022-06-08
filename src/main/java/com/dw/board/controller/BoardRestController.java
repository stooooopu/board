package com.dw.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dw.board.service.BoardService;
import com.dw.board.vo.BoardVO;
import com.github.pagehelper.PageInfo;

@RestController
@RequestMapping("/api/v1")
public class BoardRestController {

	@Autowired
	private BoardService boardService;
	
	// 게시물 저장 (C)
	@CrossOrigin
	@PostMapping("/board")
	public int callSaveBoard(@RequestBody BoardVO vo) {
		return boardService.setBoard(vo);
	}
	
//		원래 전체 게시물 조회 controller
//		@CrossOrigin
//		@GetMapping("/board")
//		public List<Map<String,Object>> callBoardList(){
//			return boardService.getAllBoardList(pageNum, pageSize);
//		}
		
	// 게시물 조회 (R)
	@CrossOrigin
	@GetMapping("/board")
	public PageInfo<Map<String,Object>> callBoardList(@RequestParam("pageNum")int pageNum,
			@RequestParam("pageSize")int pageSize){
		
		List<Map<String, Object>> list = boardService.getAllBoardList(pageNum, pageSize);
		
		return new PageInfo<Map<String,Object>>(list);
	}
	
	// 게시물 삭제 (D)
	@CrossOrigin
	@DeleteMapping("/board/boardId/{id}")
	public int callRemoveBoard(@PathVariable("id") int boardId) {
		return boardService.deleteBoard(boardId);
	}
	
	// 게시물 업데이트(U)
	@CrossOrigin
	@PatchMapping("/board/boardId/{id}")
	public int callUpdateBoard(@PathVariable("id") int boardId,
	@RequestBody BoardVO vo) {
		return boardService.updateBoard(vo, boardId);
	}

	// 게시물 상세보기(R)
	@CrossOrigin
	@GetMapping("/board/boardId/{id}")
	public BoardVO callBoard(@PathVariable("id") int boardId) {
		return boardService.getBoardContent(boardId);
	}
	
	// 게시물 카운트
	// 게시물을 클릭했을 때 조회수를 1카운트
	// 조회물 클릭 -> 웹 서버에 요청(조회수 카운트 요청)
	@CrossOrigin
	@PatchMapping("/board/views/boardId/{id}")
	public int callBoardViews(@PathVariable("id") int boardId) {
		System.out.println(boardId);
		return boardService.getUpdateBoardView(boardId);
	}

	// queryString으로 검색한 작성자 게시물 리스트 조회
	// return Type을 페이징처리했던 컨트롤러와 동일하게
	@CrossOrigin
	@GetMapping("/board/search")
	public PageInfo<Map<String,Object>> callBoardSearch(@RequestParam("writer") String writer,
			@RequestParam("pageNum")int pageNum,
			@RequestParam("pageSize")int pageSize){
		List<Map<String,Object>> list = boardService.getSearchBoardList(writer,pageNum,pageSize);
		
		return new PageInfo<Map<String,Object>>(list);
	}
	
	// 게시판 통계 조회
	@CrossOrigin
	@GetMapping("/board/statistics")
	public Map<String, Object> callBoardStatistics(){
		return boardService.getBoardStatistics();
	}
}
