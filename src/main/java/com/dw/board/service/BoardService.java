package com.dw.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dw.board.mapper.BoardMapper;
import com.dw.board.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	// insert
	@Transactional(rollbackFor = {Exception.class})
	public int setBoard(BoardVO vo) {
		return boardMapper.insertBoard(vo);
	}
	
	// get
	public List<Map<String,Object>> getAllBoardList(){
		return boardMapper.selectAllBoardList();
	}
	
	// delete
	@Transactional(rollbackFor = {Exception.class})
	public int deleteBoard(int boardId) {
		return boardMapper.deleteBoard(boardId);
	}
	
	// update
	@Transactional(rollbackFor = {Exception.class})
	public int updateBoard(BoardVO vo, int boardId) {
		vo.setBoardId(boardId);
		return boardMapper.updateBoard(vo);
	}
	
	// get
	public BoardVO getBoardContent(int boardId) {
		return boardMapper.selectBoardContent(boardId);
	}
	
	// update
	@Transactional(rollbackFor = {Exception.class})
	public int getUpdateBoardView(int boardId) {
		
		// 게시판 번호를 이용해서 조회수컬럼을 selecte
		BoardVO vo = boardMapper.selectBoardContent(boardId);
		int views = vo.getCnt();
		
		// 조회수를 1 증가시킴
		++views; 
		vo.setCnt(views);
		vo.setBoardId(boardId);

		// update
		return boardMapper.updateBoardViews(vo);
	}
	
	// get
	public List<Map<String,Object>> getSearchBoardList(String writer){
		return boardMapper.selectSearchBoardList(writer);
	}
	
}
